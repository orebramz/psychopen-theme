{**
* templates/frontend/pages/userRegister.tpl
*
* Copyright (c) 2014-2017 Simon Fraser University Library
* Copyright (c) 2003-2017 John Willinsky
* Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
* Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
*
* User registration form.
*}
{include file="frontend/components/header.tpl" pageTitle="user.register"}
<div id="main-content" class="user-register-tpl">
    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.register"}
    <form class="pkp_form register" id="register" method="post" action="{url op="register"}">
        {csrf}
        {if $source}
            <input type="hidden" name="source" value="{$source|escape}"/>
        {/if}
        {include file="common/formErrors.tpl"}
        {include file="frontend/components/registrationForm.tpl"}
        {* When a user is registering with a specific journal *}
        {if $currentContext}
            <div class="card mb-3">
                <div class="card-header font-weight-bold bg-white">
                    {translate key="plugins.themes.psychOpen.register.privacy"}
                </div>
                <div class="card-body">
                    {* Require the user to agree to the terms of the privacy policy *}
                    <label>
                        <input type="checkbox" name="privacyConsent" value="1"{if $privacyConsent} checked="checked"{/if}>
                        {capture assign="privacyUrl"}{url router=$smarty.const.ROUTE_PAGE page="about" op="privacy"}{/capture}
                        {translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
                    </label><br/>
                    {* Ask the user to opt into public email notifications *}
                    <label>
                        <input type="checkbox" name="emailConsent" value="1"{if $emailConsent} checked="checked"{/if}>
                        {translate key="user.register.form.emailConsent"}
                    </label>
                </div>
            </div>
            {* Allow the user to sign up as a reviewer *}
            {assign var=contextId value=$currentContext->getId()}
            {assign var=userCanRegisterReviewer value=0}
            {foreach from=$reviewerUserGroups[$contextId] item=userGroup}
                {if $userGroup->getPermitSelfRegistration()}
                    {assign var=userCanRegisterReviewer value=$userCanRegisterReviewer+1}
                {/if}
            {/foreach}
            {if $userCanRegisterReviewer}
                <div class="card mb-3">
                    <div class="card-header font-weight-bold bg-white">
                        {translate key="user.reviewerPrompt"}
                    </div>
                    <div class="card-body">
                        <div id="reviewerOptinGroup" class="form-group optin">
                            {foreach from=$reviewerUserGroups[$contextId] item=userGroup}
                                {if $userGroup->getPermitSelfRegistration()}
                                    <label>
                                        {assign var="userGroupId" value=$userGroup->getId()}
                                        <input type="checkbox" name="reviewerGroup[{$userGroupId}]" value="1"{if in_array($userGroupId, $userGroupIds)} checked="checked"{/if}>
                                        {translate key="user.reviewerPrompt.userGroup" userGroup=$userGroup->getLocalizedName()}
                                    </label>
                                {/if}
                            {/foreach}
                        </div>
                    </div>
                </div>
            {/if}
        {/if}
        {include file="frontend/components/registrationFormContexts.tpl"}
        {* When a user is registering for no specific journal, allow them to enter their reviewer interests *}
        {if !$currentContext}
            <div class="card mb-3">
                <div class="card-header font-weight-bold bg-white">
                    {translate key="user.register.noContextReviewerInterests"}
                </div>
                <div class="card-body">
                    <div class="reviewer_nocontext_interests">
                        {* See comment for .tag-it above *}
                        <ul class="interests tag-it" data-field-name="interests[]"
                            data-autocomplete-url="{url|escape router=$smarty.const.ROUTE_PAGE page='user' op='getInterests'}">
                            {foreach from=$interests item=interest}
                                <li>{$interest|escape}</li>
                            {/foreach}
                        </ul>
                    </div>
                </div>
            </div>
            {* Require the user to agree to the terms of the privacy policy *}
            {if $siteWidePrivacyStatement}
                <div class="row">
                    <div class="col">
                        <label>
                            <input type="checkbox" name="privacyConsent[{$smarty.const.CONTEXT_ID_NONE}]" id="privacyConsent[{$smarty.const.CONTEXT_ID_NONE}]"
                                   value="1"{if $privacyConsent[$smarty.const.CONTEXT_ID_NONE]} checked="checked"{/if}>
                            {capture assign="privacyUrl"}{url router=$smarty.const.ROUTE_PAGE page="about" op="privacy"}{/capture}
                            {translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
                        </label>
                    </div>
                </div>
            {/if}
            {* Ask the user to opt into public email notifications *}
            <div class="row">
                <div class="col">
                    <label>
                        <input type="checkbox" name="emailConsent" value="1"{if $emailConsent} checked="checked"{/if}>
                        {translate key="user.register.form.emailConsent"}
                    </label>
                </div>
            </div>
        {/if}
        {* recaptcha spam blocker *}
        {if $reCaptchaHtml}
            <div class="card mb-3">
                <div class="card-header font-weight-bold bg-white">
                    reCaptcha
                </div>
                <div class="card-body">
                    <div class="form-group recaptcha">
                        {$reCaptchaHtml}
                    </div>
                </div>
            </div>
        {/if}
        <div class="row mb-5 mt-3">
            <div class="col-12">
                {*{capture assign="rolesProfileUrl"}{url page="user" op="profile" path="roles"}{/capture}
                <a class="btn btn-default" href="{url page="login" source=$rolesProfileUrl}" class="login">
                    {translate key="user.login"}
                </a>*}
                <button class="btn btn-outline-success btn-sm float-right" type="submit" id="submitReg">
                    {translate key="user.register"}
                </button>
            </div>
        </div>
    </form>
</div>
{include file="frontend/components/footer.tpl"}