# FUAP Contribution Guidelines

## Overview

This document outlines the contribution process and standards for the FUAP project, ensuring smooth collaboration, consistent code quality, and effective project management.

## Getting Started

* Clone the repository:

  ```bash
  git clone https://github.com/your-username/fuap.git
  ```

* Set up your local development environment following the [Onboarding Documentation](docs/onboarding/Onboarding_Documentation.md).

## Contribution Workflow

### Branching Strategy

* Always branch from the latest `develop` branch:

  ```bash
  git checkout develop
  git pull origin develop
  git checkout -b feature/your-feature-name
  ```

### Commit Messages

* Follow [Conventional Commit](https://www.conventionalcommits.org/en/v1.0.0/) standards:

  ```Commits
  feat: add user authentication via Firebase
  fix: correct login issue
  docs: update contribution guidelines
  ```

### Pull Requests

* Clearly title and describe the changes.
* Reference related GitHub issues.
* Keep pull requests focused and small to facilitate easier reviews.
* Ensure your code passes all tests and `linting` checks before submission.

## Coding Standards

* Adhere to the [FUAP Coding Standards and Style Guides](docs/Coding_Standards_and_Style_Guides.md).
* Ensure your code is clean, maintainable, and clearly documented.

## Testing

* Write and include relevant tests for all new features and bug fixes.
* Ensure existing tests pass before submitting your pull request.

## Issue Reporting

* Clearly describe the issue, including steps to reproduce, expected behavior, and actual behavior.
* Provide relevant logs, screenshots, or error messages when applicable.
* Label issues appropriately (bug, enhancement, question, etc.).

## Code Reviews

* Required for every pull request.
* Engage constructively with reviewers, addressing feedback and questions.
* Reviewers should check for adherence to coding standards, maintainability, functionality, and completeness.

## Communication

* Utilize GitHub Issues and Discussions for feature discussions, planning, and clarification.
* Be respectful and professional in all interactions.

## Merging

* Pull requests are merged only after approval from at least one project maintainer and successful CI/CD pipeline runs.
* Maintainers handle merges to ensure consistency.

## Licensing

* All contributions must comply with the project's licensing terms.

## Questions and Support

* For questions or assistance, reach out via GitHub Discussions or directly contact maintainers listed in the README.

Thank you for contributing to the FUAP project!
