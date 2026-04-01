#!/usr/bin/bash

set -e

setup_environment(){

    python3 -m venv venv

    . venv/bin/activate


    case "$BRANCH_NAME" in 
        Main)
        TEST_DIR="odoo15_selenium_tests_Main"
        ;;

        Work-pc)
        TEST_DIR="odoo15_selenium_tests_Work-pc"
        ;;

        Home-pc/*)
        TEST_DIR="odoo15_selenium_tests_Home-pc"
        exit 1
        ;;
    esac

    pip install -r "/var/lib/jenkins/workspace/$TEST_DIR/odoo_sandbox/requirements.txt"
}

run_tests(){

. venv/bin/activate

case "$BRANCH_NAME" in
    Main)
        TEST_DIR="odoo15_selenium_tests_Main"
    ;;

    Work-pc)
        TEST_DIR="odoo15_selenium_tests_Work-pc"
    ;;

    Home-pc)
        TEST_DIR="odoo15_selenium_tests_Home-pc"
    ;;
esac

pytest -q --tb=short "/var/lib/jenkins/workspace/$TEST_DIR/odoo_sandbox/authentication/test_login.py::test_invalid_login"

echo "Tests ran successfully!"

}

deploy_changes(){
    ssh kkiarie@sandbox.erp.quatrixglobal.com /opt/scripts/update_odoo.sh

    
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
        exit 1

        ;;
esac


