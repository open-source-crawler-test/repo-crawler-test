# Repository Scanning Web Crawler [![CI](https://github.com/open-source-crawler-test/repo-crawler-test/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/open-source-crawler-test/repo-crawler-test/actions/workflows/ci.yml)

An out-of-the-box repository typos/vulnerabilites scanner, with ability to crawl GitHub finding more open source projects.

### 🌟 Overview
- *Web crawler* parsing GitHub URLs found in repository READMEs
- *Repository scanner*  searching for typos, leaked credentials, security vulnerabilites, or dependency issues
- User friendly reports generated to display scan results
- *`Bash`* scripts syncing with *`RedisDB`* to store URLs
- Continuous integration w/ unit tests for bash script logic using `bats` framework
- GitHub Actions executing bash scripts - triggered via CRON job or manually dispatch

```yml
- ⚠️ Finish `# TODO` items
- TEST Validate cannot scan twice
- TEST Validate cannot crawl twice
- `./scripts/executeRepositoryWebCrawl.sh open-source-crawler-test/repo-known-bad`
- Find and replace all `$CRAWL_QUEUE_KEY` values
- TODO - conditionally trigger email
- TODO - conditionally trigger archive commit
```

## Usage

To set up your own web/repo crawler, you can fork this entire repo, updates repository secrets, and view the reports generated in the JOB_SUMMARY output.

> Prerequisite: need a running RedisDB with known credentials

1. Fork this entire repository
2. Set up a Redis database, save the credentials
3. Set the repository secrets:

```yml
REDIS_HOST: ${{ secrets.REDIS_HOST }}
REDIS_PORT: ${{ secrets.REDIS_PORT }}
REDIS_PASS: ${{ secrets.REDIS_PASS }}
REDIS_USER: ${{ secrets.REDIS_USER }}
```

4. Update workflow configuration options (search for `env:` in /workflows/*.yml)

```yml
typo-scan-exclude-match: '[''typos-report/**'', ''public/**'']'
```

5. Trigger `workflow_dispatch` for the `Seed Crawl Queue` action (provide a string `user/a-cool-repo` as input)
6. Configure/Enable the  `Repo Web Crawler CRON` job for automatic web crawling
7. Configure/Enable the `Repo Scan CRON` job for automatic repo scanning
8. OR trigger the `Repo Scan Manual` workflow whenever

## Extended Usage

Optionally, you can archive all reports in a repository, AND/OR generate email notifications for every scans fail/pass status.

> Prerequisites: Need a second empty GitHub repository (eg. *my-scan-ouput-repo*), and valid email account credentials

1. Create an empty repository to dump folders into (eg: `myusername/my-repo-scan-archive`)
2. Generate an ACCESS_TOKEN with write permission to that repository [(see the docs)](https://docs.github.com/en/enterprise-server@3.4/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
3. Update the repository secrets:

```yml
REDIS_XXX: ...
...
ARCHIVE_REPO_ACCESS_TOKEN: ${{ secrets.PERSONAL_ACCESS_TOKEN }} # GitHub Access Token with write permissions to archive repository
```

5. Update workflow configuration options (search /workflows/*.yml for `env:`)

```yml
typo-scan-exclude-match: ...
REPORT_ARCHIVE_OWNER: open-source-crawler-test
REPORT_ARCHIVE_REPO: repo-scan-archive-test
ARCHIVE_REPO_BRANCH_TARGET: main
ARCHIVE_COMMIT_EMAIL: commit-bot@gmail.com
```

6. That's it! Manully trigger crawls/scans, or watch the CRON job do its magic. View all of the reports later on.

## Configuration Options

By default, this scanner 

TODO

```yml
typo-scan-exclude-match: '[''typos/**'', ''public/**'']'
```