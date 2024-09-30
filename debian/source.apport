"""Apport package hook for dracut."""

import pathlib
import typing

from apport import packaging
from problem_report import ProblemReport


def add_info(report: ProblemReport, _ui: typing.Any) -> None:
    """Add details for dracut to Apport bug report."""
    packages_with_modules = set()
    unknown_modules = set()
    for path in pathlib.Path("/usr/lib/dracut/modules.d").iterdir():
        package = packaging.get_file_package(str(path))
        if package is None:
            unknown_modules.add(path.name)
        else:
            packages_with_modules.add(package)

    dracut_modules_packages = []
    for package in sorted(packages_with_modules):
        version = packaging.get_version(package)
        dracut_modules_packages.append(f"{package} {version}")

    report["DracutModulesPackages"] = "\n".join(dracut_modules_packages)
    if unknown_modules:
        report["DracutModules"] = " ".join(sorted(unknown_modules))
