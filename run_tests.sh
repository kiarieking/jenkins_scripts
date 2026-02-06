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
