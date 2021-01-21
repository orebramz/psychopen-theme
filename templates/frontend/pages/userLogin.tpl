{**
 * templates/frontend/pages/userLogin.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2000-2017 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User login form.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login"}
<div id="main-content" class="page page_login test">
    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.login"}
    <div class="row justify-content-md-center">
        <div class="col-md-6">
            {* A login message may be displayed if the user was redireceted to the
               login page from another request. Examples include if login is required
               before dowloading a file. *}
            {if $loginMessage}
                <div class="alert alert-info" role="alert">
                    {translate key=$loginMessage}
                </div>
            {/if}
	        {* TODO Anfang Informations Block über Umzug! Entfernen wenn alles fertig ist *}
	        {*
			{if $currentJournal && $currentJournal->getId() == 15}
				<div class="alert alert-info" role="alert">
				   <div>The <em>Social Pschological Bulletin (SPB)</em> has moved to a new journal management system. If you already have an user account for SPB you need to follow the <a href="/index.php/cpe/login/lostPassword">"Forgot your password?"</a> link, to receive a new password for your account at the new system. If you need further support, contact <strong><a href="mailto:support@spb.psychopen.eu">support@spb.psychopen.eu</a></strong>. Sorry for the inconvenience!</div>
				</div>
			{/if}
			*}
	        {*
			{if $currentJournal && $currentJournal->getId() == 17}
				<div class="alert alert-info" role="alert">
				   <div><em>Clinical Psychology in Europe (CPE)</em> has moved to a new journal management system. If you already have an user account for CPE you need to follow the <strong><a href="/index.php/cpe/login/lostPassword">"Forgot your password?"</a></strong> link, to receive a new password for your account at the new system. If you need further support, contact <strong><a href="mailto:support@cpe.psychopen.eu">support@cpe.psychopen.eu</a></strong>. Sorry for the inconvenience!</div>
				</div>
			{/if}
			*}
	        {if $currentJournal && $currentJournal->getId() == 23}
		        <div class="alert alert-info" role="alert">
			        <div><strong>Authors:</strong> <em>Checking the status of your submission?</em><br /> Please note: This is the login page of the <em>new</em> website of the <em>Journal of Social and Political Psychology</em> (JSPP). If you submitted a paper to the <em>old</em> system (before December 01, 2020) you need to log into the old website here: <strong><a href="https://jspp-old.psychopen.eu/login/">jspp-old.psychopen.eu/login</a></strong>. If you need further support, contact <strong><a href="mailto:support@jspp.psychopen.eu">support@jspp.psychopen.eu</a></strong>. Apologies for the inconvenience!</div>
		        </div>
	        {/if}
	        {if $currentJournal && $currentJournal->getId() == 25}
		        <div class="alert alert-info" role="alert">
			        <div><strong>Authors:</strong> <em>Checking the status of your submission?</em><br />Please note: This is the login page of the <em>new</em> website of the <em>Journal of Numerical Cognition</em> (JNC). If you submitted a paper to the <em>old</em> system (before January 20, 2021) you need to log into the old website here: <strong><a href="https://jnc-old.psychopen.eu/login/">jnc-old.psychopen.eu/login</a></strong>. If you need further support, contact <strong><a href="mailto:support@jnc.psychopen.eu">support@jnc.psychopen.eu</a></strong>. Apologies for the inconvenience!</div>
		        </div>
	        {/if}
			{* TODO Ende Informations Block über Umzug! *}
            <form class="pkp_form login" id="login" method="post" action="{$loginUrl}">
                {csrf}
                <input type="hidden" name="source" value="{$source|strip_unsafe_html|escape}"/>
                {if $error}
                    <div class="alert alert-danger" role="alert">
                        {translate key=$error reason=$reason}
                    </div>
                {/if}
                <div class="form-group mt-3">
                    <label for="login-username">{translate key="user.username"}</label>
                    <input type="text" name="username" class="form-control" id="login-username" placeholder="{translate key='user.username'}" value="{$username|escape}"
                           maxlenght="32"
                           required>
                </div>
                <div class="form-group">
                    <label for="login-password">{translate key="user.password"}</label>
                    <input type="password" name="password" class="form-control" id="login-password" placeholder="{translate key='user.password'}" password="true" maxlength="32"
                           required="$passwordRequired">
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="remember" id="remember" value="1" checked="$remember"> {translate key="user.login.rememberUsernameAndPassword"}
                    </label>
                </div>
                <div class="row mt-2">
                    <div class="col-12">
                        <button type="submit" class="btn btn-outline-success">
                            {translate key="user.login"}
                        </button>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-12">
                        <a href="{url page="login" op="lostPassword"}">
                            {translate key="user.login.forgotPassword"}
                        </a>
                    </div>
                </div>
                {if !$disableUserReg}
                    <div class="alert alert-secondary" role="alert">
                        {capture assign="registerUrl"}{url page="user" op="register" source=$source}{/capture}
                        <a href="{$registerUrl}" role="button">
                            {translate key="user.login.registerNewAccount"}
                        </a>
                    </div>
                {/if}
            </form>
        </div>
    </div>
</div><!-- .page -->
{include file="frontend/components/footer.tpl"}
