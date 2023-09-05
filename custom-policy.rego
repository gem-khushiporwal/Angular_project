package main

deny[msg] {
    input.Vulnerability.Severity == "CRITICAL"
    msg = "Critical vulnerabilities are not allowed"
}
