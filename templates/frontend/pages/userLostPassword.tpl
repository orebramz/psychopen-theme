{**
 * templates/frontend/pages/userLostPassword.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2000-2017 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Password reset form.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login.resetPassword"}
<div id="main-content" class="page page_lost_password">
    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.login"}
    <div class="alert alert-info" role="alert">
        {translate key="user.login.resetPasswordInstructions"}
    </div>
    <form id="lostPasswordForm" action="{url page="login" op="requestResetPassword"}" method="post">
        {csrf}
        {if $error}
            <div class="alert alert-error" role="alert">
                {translate key=$error}
            </div>
        {/if}
        <div class="input-group mb-5 mt-5">
            <input type="email" name="email" class="form-control" id="login-email" placeholder="{translate key='user.login.registeredEmail'}" value="{$email|escape}"
                   maxlenght="32"
                   required>
            <div class="input-group-append">
                <button type="submit" class="btn btn-outline-success">
                    {translate key="user.login.resetPassword"}
                </button>
            </div>
        </div>
        {if !$disableUserReg}
            <div class="row justify-content-center mb-5">
                <div class="col">
                    <div class="alert alert-secondary text-center" role="alert">
                        {capture assign="registerUrl"}{url page="user" op="register" source=$source}{/capture}
                        <a href="{$registerUrl}" role="button">
                            {translate key="user.login.registerNewAccount"}
                        </a>
                    </div>
                </div>
            </div>
        {/if}
    </form>
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
