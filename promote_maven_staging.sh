#!/bin/bash
# Promotes the staged artifacts to a Central Portal deployment, which then has to be released from
# https://central.sonatype.com/publishing/deployments

set -e

NAMESPACE="${SONATYPE_NAMESPACE:-com.ionspin.kotlin}"
LOCAL_PROPERTIES="$(dirname "$0")/local.properties"

readLocalProperty() {
  if [ -f "$LOCAL_PROPERTIES" ]; then
    sed -n "s/^[[:space:]]*$1[[:space:]]*=[[:space:]]*//p" "$LOCAL_PROPERTIES" | tail -n 1
  fi
}

if [ -z "$SONATYPE_BASE64" ]; then
  USERNAME="${SONATYPE_USERNAME:-$(readLocalProperty sonatypeUsername)}"
  PASSWORD="${SONATYPE_PASSWORD:-$(readLocalProperty sonatypePassword)}"
  if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
    echo "No SONATYPE_BASE64, and no sonatypeUsername/sonatypePassword in the environment or in local.properties" >&2
    exit 1
  fi
  SONATYPE_BASE64="$(printf '%s:%s' "$USERNAME" "$PASSWORD" | base64 | tr -d '\n')"
fi

# No -v here, curl prints the authorization header in verbose mode
curl -X POST "https://ossrh-staging-api.central.sonatype.com/manual/upload/defaultRepository/$NAMESPACE" \
  -H "Authorization: Bearer $SONATYPE_BASE64" \
  --fail-with-body -sS -w '\nHTTP %{http_code}\n'
