with process_step(display_name = "login_to_asana", description_md_key = "login_to_asana_0e62f131-1f20-410c-b624-ca8f1b696371",
    input_params = [{"name": "browser"},{"name": "login_to_Asana_email"}, {"name": "login_to_Asana_password"}], output_params = [{"name": "login_success"}]) as login_to_asana:
    # Get login credentials from runtime config
    email = runtime_config("ASANA_LOGIN_EMAIL")
    # Initialize login success flag
    login_success = False
    # Use browser context for all browser operations
    with host() as h:
      with h.browser() as browser:
        # Navigate to Asana login page
        browser.go_to_url(url = "https://app.asana.com/")
        # Type in email
        browser.type_in(element = "Email input field", input = email)
        # Click Continue/Next button after email
        browser.mouse_click(element = "Continue button after email")
        # Type in password using secret
        browser.type_in_secret(element = "Password input field", secret_reference = "password_Asana",
          secret_attribute = "password")
        # Click login button
        browser.mouse_click(element = "Log in button")
        # Check if we successfully logged in by looking for home page elements
        home_text = browser.read(element = "Home page heading or dashboard element")
        # Set success based on whether we see home page elements
        if "Home" in home_text or "My Tasks" in home_text or "Projects" in home_text:
          login_success = True
