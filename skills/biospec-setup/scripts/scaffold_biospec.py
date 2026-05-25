#!/usr/bin/env python3
"""Scaffold a BioSpec directory from bundled templates."""

from __future__ import annotations

import argparse
import datetime as _dt
import re
import sys
from pathlib import Path


ROOT_FILES = (
    "project_overview.md",
    "project_resources.md",
    "intent_overview.md",
    "dataset_overview.md",
    "analysis_overview.md",
    "dependencies.md",
)

BOOTSTRAP_SNIPPET = (
    "This repository uses BioSpec. The `biospec/` directory contains the "
    "authoritative project specification (intents, datasets, analyses, "
    "dependencies, project overview, resources, and a decisions register). "
    "Before planning, editing, or reviewing scientific content, read the "
    "relevant BioSpec files. Use the BioSpec skills for any writes: "
    "`biospec-setup`, `biospec-autofill`, `biospec-edit`, `biospec-review`, "
    "`biospec-sync`. Never invent data, methods, or hypotheses; never delete "
    "files without explicit confirmation."
)

LAST_UPDATED_RE = re.compile(r"^last_updated:\s*.*$", re.MULTILINE)
DATE_RE = re.compile(r"^\d{4}-\d{2}-\d{2}$")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Copy BioSpec templates and stamp last_updated dates."
    )
    parser.add_argument(
        "--repo-root",
        type=Path,
        default=Path.cwd(),
        help="Repository root where biospec/ should be created.",
    )
    parser.add_argument(
        "--date",
        default=_dt.date.today().isoformat(),
        help="ISO date for last_updated. Defaults to today's local date.",
    )
    parser.add_argument(
        "--bootstrap",
        action="append",
        choices=("AGENTS.md", "CLAUDE.md"),
        default=[],
        help="Append the BioSpec bootstrap snippet to this file. Repeatable.",
    )
    parser.add_argument(
        "--overwrite",
        action="store_true",
        help="Overwrite existing target files. Use only after explicit approval.",
    )
    parser.add_argument(
        "--apply",
        action="store_true",
        help="Write files. Omit for dry-run output only.",
    )
    return parser.parse_args()


def templates_dir() -> Path:
    script = Path(__file__).resolve()
    return script.parents[2] / "biospec-templates" / "assets" / "templates"


def stamped_template(source: Path, date: str) -> str:
    text = source.read_text(encoding="utf-8")
    replacements = LAST_UPDATED_RE.findall(text)
    if len(replacements) != 1:
        raise ValueError(f"{source} must contain exactly one last_updated line")
    return LAST_UPDATED_RE.sub(f"last_updated: {date}", text)


def planned_targets(repo_root: Path, template_root: Path) -> list[tuple[Path, Path]]:
    biospec = repo_root / "biospec"
    targets = []
    for filename in ROOT_FILES:
        targets.append((biospec / filename, template_root / filename))
    targets.append(
        (
            biospec / "registers" / "decisions.md",
            template_root / "subtemplates" / "decisions.md",
        )
    )
    return targets


def append_bootstrap(path: Path) -> str:
    if path.exists():
        text = path.read_text(encoding="utf-8")
        if BOOTSTRAP_SNIPPET in text:
            return "skipped existing bootstrap"
        separator = "" if text.endswith("\n") else "\n"
        path.write_text(f"{text}{separator}\n{BOOTSTRAP_SNIPPET}\n", encoding="utf-8")
        return "appended bootstrap"

    path.write_text(f"{BOOTSTRAP_SNIPPET}\n", encoding="utf-8")
    return "created with bootstrap"


def main() -> int:
    args = parse_args()
    if not DATE_RE.match(args.date):
        print(f"error: --date must be YYYY-MM-DD, got {args.date!r}", file=sys.stderr)
        return 2

    repo_root = args.repo_root.resolve()
    template_root = templates_dir()
    if not template_root.is_dir():
        print(f"error: template directory not found: {template_root}", file=sys.stderr)
        return 1

    dirs = [
        repo_root / "biospec",
        repo_root / "biospec" / "intents",
        repo_root / "biospec" / "datasets",
        repo_root / "biospec" / "analyses",
        repo_root / "biospec" / "registers",
    ]
    targets = planned_targets(repo_root, template_root)
    existing = [target for target, _source in targets if target.exists()]

    print(f"BioSpec scaffold plan for {repo_root}")
    print(f"date: {args.date}")
    for directory in dirs:
        print(f"mkdir {directory.relative_to(repo_root)}")
    for target, source in targets:
        action = "overwrite" if target.exists() else "copy"
        print(
            f"{action} {source.relative_to(template_root)}"
            f" -> {target.relative_to(repo_root)}"
        )
    for filename in args.bootstrap:
        print(f"append bootstrap -> {filename}")

    if existing and not args.overwrite:
        print("\nblocked: target files already exist; rerun with --overwrite only after approval")
        return 1

    if not args.apply:
        print("\ndry run: no changes written; rerun with --apply after user approval")
        return 0

    for directory in dirs:
        directory.mkdir(parents=True, exist_ok=True)
    for target, source in targets:
        target.write_text(stamped_template(source, args.date), encoding="utf-8")
    for filename in args.bootstrap:
        result = append_bootstrap(repo_root / filename)
        print(f"{result}: {filename}")

    print("\nwritten")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
