# Repository Scanning Web Crawler [![CI](https://github.com/open-source-crawler-test/repo-crawler-test/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/open-source-crawler-test/repo-crawler-test/actions/workflows/ci.yml)


## Repository Secrets

```yml
REDIS_HOST: ${{ secrets.REDIS_HOST }}
REDIS_PORT: ${{ secrets.REDIS_PORT }}
REDIS_PASS: ${{ secrets.REDIS_PASS }}
REDIS_USER: ${{ secrets.REDIS_USER }}
ARCHIVE_REPO_ACCESS_TOKEN: ${{ secrets.PERSONAL_ACCESS_TOKEN }} # GitHub Access Token with write permissions to archive repository
typo-scan-exclude-match: '[''typos/**'', ''public/**'']'
REPORT_ARCHIVE_OWNER: open-source-crawler-test
REPORT_ARCHIVE_REPO: repo-scan-archive-test
ARCHIVE_REPO_BRANCH_TARGET: main
ARCHIVE_COMMIT_EMAIL: commit-bot@gmail.com
```