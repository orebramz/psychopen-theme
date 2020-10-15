{**
 * templates/frontend/components/registrationForm.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the basic registration form fields
 *
 * @uses $locale string Locale key to use in the affiliate field
 * @uses $firstName string First name input entry if available
 * @uses $middleName string Middle name input entry if available
 * @uses $lastName string Last name input entry if available
 * @uses $countries array List of country options
 * @uses $country string The selected country if available
 * @uses $email string Email input entry if available
 * @uses $username string Username input entry if available
 *}
<div class="card mb-3">
    <div class="card-header font-weight-bold bg-white">
        {translate key="plugins.themes.psychOpen.register.user"}
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-12 col-md-6 form-group">
                <label for="givenName">
                    {translate key="plugins.themes.psychOpen.user.first.name"}
                    <span class="form-control-required">*</span>
                    <span class="sr-only">{translate key="common.required"}</span>
                </label>
                <input class="form-control" type="text" name="givenName" id="givenName" value="{$givenName|escape}" maxlength="255" required>
            </div>
            <div class="col-12 col-md-6 form-group">
                <label for="familyName">
                    {translate key="plugins.themes.psychOpen.user.last.name"}
                    <span class="form-control-required">*</span>
                    <span class="sr-only">{translate key="common.required"}</span>
                </label>
                <input class="form-control" type="text" name="familyName" id="familyName" value="{$familyName|escape}" maxlength="255" required>
            </div>
        </div>
        <div class="row">
            <div class="col-12 col-md-8 form-group">
                <label>
                    {translate key="user.affiliation"}
                    <span class="form-control-required">*</span>
                    <span class="sr-only">{translate key="common.required"}</span>
                </label>
                <input class="form-control" type="text" name="affiliation" id="affiliation" value="{$affiliation|escape}" required>
            </div>
            <div class="col-12 col-md-4 form-group">
                <label>
                    {translate key="common.country"}
                    <span class="form-control-required">*</span>
                    <span class="sr-only">{translate key="common.required"}</span>
                </label>
                <select class="form-control" name="country" id="country" required>
                    <option></option>
                    {html_options options=$countries selected=$country}
                </select>
            </div>
        </div>
    </div>
</div>

<div class="card mb-3">
    <div class="card-header font-weight-bold bg-white">
        {translate key="plugins.themes.psychOpen.register.login"}
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-6 col-12">
                <div class="form-group">
                    <label>
                        {translate key="user.email"}
                        <span class="form-control-required">*</span>
                        <span class="sr-only">{translate key="common.required"}</span>
                    </label>
                    <input class="form-control" type="text" name="email" id="email" value="{$email|escape}" maxlength="90" required>
                </div>
                <div class="form-group">
                    <label>
                        {translate key="user.username"}
                        <span class="form-control-required">*</span>
                        <span class="sr-only">{translate key="common.required"}</span>
                    </label>
                    <input class="form-control" type="text" name="username" id="username" value="{$username|escape}" maxlength="32" required>
                </div>
            </div>
            <div class="col-md-6 col-12">
                <div class="form-group password">
                    <label>
                        {translate key="user.password"}
                        <span class="form-control-required">*</span>
                        <span class="sr-only">{translate key="common.required"}</span>
                    </label>
                    <input class="form-control" type="password" name="password" id="password" password="true" maxlength="32" required>
                    </label>
                </div>
                <div class="form-group password">
                    <label>
                        {translate key="user.repeatPassword"}
                        <span class="form-control-required">*</span>
                        <span class="sr-only">{translate key="common.required"}</span>
                    </label>
                    <input class="form-control" type="password" name="password2" id="password2" password="true" maxlength="32" required>
                </div>
            </div>
        </div>
    </div>
</div>
