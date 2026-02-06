#!/usr/bin/bash

echo "hello world"

pwd

python3 --version

python3 -m venv venv

. venv/bin/activate


case "$BRANCH_NAME" in 
    Main)
    TEST_DIR="odoo_selenium_tests_Main"
    ;;

    Work-pc)
    TEST_DIR="odoo_selenium_tests_Work-pc"
    ;;

    Home-pc/*)
    TEST_DIR="odoo_selenium_tests_Home-pc"
    exit 1
    ;;
esac

pip install -r "/var/lib/jenkins/workspace/$TEST_DIR/odoo_sandbox/requirements.txt"
