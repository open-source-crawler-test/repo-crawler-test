#!/usr/bin/env bats

setup() {
    load 'assert'

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    chmod -R +rwx scripts
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$DIR/../scripts:$PATH"
}

@test "should reject undefined repository input" {
    source validateRepoUrlInput.sh
    run validateRepoUrlInput ""
    assert_failure
    assert_output 'Invalid repository user/name input provided'
}

@test "should reject invalid repository input" {
    source validateRepoUrlInput.sh
    run validateRepoUrlInput "not-a-repo"
    assert_failure
    assert_output 'Invalid repository user/name input provided'

    run validateRepoUrlInput "&&&&fakerepo/specialchars"
    assert_failure
    assert_output 'Invalid repository user/name input provided'

    run validateRepoUrlInput "999/test/bad"
    assert_failure
    assert_output 'Invalid repository user/name input provided'

    run validateRepoUrlInput "999/"
    assert_failure
    assert_output 'Invalid repository user/name input provided'

    run validateRepoUrlInput "/"
    assert_failure
    assert_output 'Invalid repository user/name input provided'

    run validateRepoUrlInput "/test-repo"
    assert_failure
    assert_output 'Invalid repository user/name input provided'
}

@test "should accept valid repository input" {
    source validateRepoUrlInput.sh
    run validateRepoUrlInput "spencerlepine/test-repo-name"
    assert_output ''
}

@test "should reject undefined redis creds input" {
    source validateRedisCreds.sh
    run validateRedisCreds "" "" "" ""
    assert_failure
    assert_output 'Invalid redis credentials provided'

    run validateRedisCreds "" ""
    assert_failure
    assert_output 'Invalid redis credentials provided'
}

@test "should accept valid redis cred input" {
    source validateRedisCreds.sh
    run validateRedisCreds "SOMEHOST" "SOMEPORT" "SOMEUSER" "SOMEPASS"
    assert_output ''
}