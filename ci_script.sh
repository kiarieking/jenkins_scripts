#!/usr/bin/env bash

set -e

test_fn(){
    echo "I'm here"
}

setup_environment(){

    python3 -m venv venv

    . venv/bin/activate


    case "$BRANCH_NAME" in 
        Main)
        TEST_DIR="odoo_selenium_tests_Main"
        ;;

        Work-pc)
        TEST_DIR="odoo_selenium_tests_Work-pc"
        ;;

        Home-pc)
        TEST_DIR="odoo_selenium_tests_Home-pc"
        ;;
    esac

    pip install -r "/var/lib/jenkins/workspace/$TEST_DIR/odoo_sandbox/requirements.txt"
}

run_tests(){

. venv/bin/activate

case "$BRANCH_NAME" in
    Main)
        TEST_DIR="odoo_selenium_tests_Main"
    ;;

    Work-pc)
        TEST_DIR="odoo_selenium_tests_Work-pc"
    ;;
    Home-pc)
        TEST_DIR="odoo_selenium_tests_Home-pc"
    ;;
esac

pytest -q --tb=short "/var/lib/jenkins/workspace/$TEST_DIR/odoo_sandbox/authentication/test_login.py::test_valid_login"

echo "Tests ran successfully!"

}

case "$1" in 
    stage_setup_environment)
        setup_environment
    ;;
    stage_run_tests)
        run_tests
    ;;
    *)

        echo "Usage: $0 {stage_setup_environment | stage_run_tests}"
        

        ;;
esac




