UPSSTREAM_BRANCH="development"
GITHUB_USER="flywheelms"
CURRENT_BRANCH="GitLab"

UPSTREAM_URL="$(git config --get remote.upstream.url | sed 's/git@//' | sed 's/com:/com\//' | sed 's/\.git//')/compare/${UPSTREAM_BRANCH}...${GITHUB_USER}:${CURRENT_BRANCH}?expand=1"

echo $UPSTREAM_URL
