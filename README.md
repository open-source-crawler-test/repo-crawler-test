# Repository Scanning Web Crawler [![CI](https://github.com/open-source-crawler-test/repo-crawler-test/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/open-source-crawler-test/repo-crawler-test/actions/workflows/ci.yml)


- ⚠️ Finish `# TODO` items
- Validate cannot scan twice
- Validate cannot crawl twice
- `./scripts/executeRepositoryWebCrawl.sh open-source-crawler-test/repo-known-bad`

## Usage


1. Fork this entire repository
2. Set up a Redis database, save the credentials
3. Set the repository secrets:

```yml
REDIS_HOST: ${{ secrets.REDIS_HOST }}
REDIS_PORT: ${{ secrets.REDIS_PORT }}
REDIS_PASS: ${{ secrets.REDIS_PASS }}
REDIS_USER: ${{ secrets.REDIS_USER }}
ARCHIVE_REPO_ACCESS_TOKEN: ${{ secrets.PERSONAL_ACCESS_TOKEN }} # GitHub Access Token with write permissions to archive repository
```

4. Create an empty repository to dump folders into (eg: `myusername/my-repo-scan-archive`)
5. Update workflow configuration options (search /workflows/*.yml for `env:`)

```yml
typo-scan-exclude-match: '[''typos/**'', ''public/**'']'
REPORT_ARCHIVE_OWNER: open-source-crawler-test
REPORT_ARCHIVE_REPO: repo-scan-archive-test
ARCHIVE_REPO_BRANCH_TARGET: main
ARCHIVE_COMMIT_EMAIL: commit-bot@gmail.com
```

6. Run the 'Seed Crawl Queue' to give the web crawler a starting URL
7. Configure/Enable the  `Repo Web Crawler CRON` job for automatic web crawling
8. Configure/Enable the `Repo Scan CRON` job for automatic repo scanning
9. Optionally trigger the `Manual Repo Scan` workflow
