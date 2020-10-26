{*
 * templates/openidLogin.tpl
 *
 * This file is part of OpenID Authentication Plugin (https://github.com/leibniz-psychology/pkp-openid).
 *
 * OpenID Authentication Plugin is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * OpenID Authentication Plugin is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OpenID Authentication Plugin.  If not, see <https://www.gnu.org/licenses/>.
 *
 * Copyright (c) 2020 Leibniz Institute for Psychology Information (https://leibniz-psychology.org/)
 *
 * Display the OpenID sign in page
 *}
{include file="frontend/components/header.tpl" pageTitle='plugins.generic.openid.select.provider'}
<div class="page page_openid_login" id="main-content">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey='plugins.generic.openid.select.provider'}
	{if $loginMessage}
		<div>
			<p>
				{translate key=$loginMessage}
			</p>
		</div>
	{/if}
	{if $openidError}
		<div class="openid-error">
			<div>{translate key=$errorMsg supportEmail=$supportEmail}</div>
			{if $reason}
				<p>{$reason}</p>
			{/if}
		</div>
		{if not $legacyLogin && not $accountDisabled}
			<div class="openid-info margin-top-30">
				{translate key="plugins.generic.openid.error.legacy.link" legacyLoginUrl={url page="login" op="legacyLogin"}}
			</div>
		{/if}
	{/if}
	<div class="row justify-content-center">
		<div class="col-12 col-xl-4">
			<ul class="list-group list-group-flush">
				{if $legacyLogin}
					<li class="list-group-item"><strong>{translate key='plugins.generic.openid.select.legacy' journalName=$journalName|escape}</strong></li>
					<li class="list-group-item">
						<form class="cmp_form cmp_form login" id="login" method="post" action="{$loginUrl}">
							{csrf}
							<div class="form-group">
								<label for="username">{translate key="user.username"}<span class="required" aria-hidden="true">*</span></label>
								<input class="form-control" type="text" name="username" id="username" value="{$username|escape}" maxlength="32" required
								       aria-required="true">
							</div>
							<div class="form-group">
								<label for="password">{translate key="user.password"}<span class="required" aria-hidden="true">*</span></label>
								<input class="form-control" type="password" name="password" id="password" value="{$password|escape}" maxlength="32" required
								       aria-required="true">
								<small class="form-text text-muted text-right">
									<a href="{url page="login" op="lostPassword"}">{translate key="user.login.forgotPassword"}</a>
								</small>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="checkbox" name="remember" id="remember" value="1">
								<label class="form-check-label" for="remember">{translate key="user.login.rememberUsernameAndPassword"}</label>
							</div>
							<div class="form-group row mt-3">
								<div class="col">
									<button class="btn btn-primary btn-block" type="submit">{translate key="user.login"}</button>
								</div>
							</div>
						</form>
					</li>
				{/if}
				{if $linkList}
					<li class="list-group-item">
						<div class="row mb-3 mt-3">
							<div class="col-12"><strong>{translate key='plugins.generic.openid.select.provider.help'}</strong></div>
						</div>
						{foreach from=$linkList key=name item=url}
							{if $name == 'custom'}
								<div class="btn btn-outline-dark btn-block mb-1 text-left">
									<a href="{$url}" style="color: inherit !important;">
										<div>
											{if $customBtnImg}
												<img src="{$customBtnImg}" alt="{$name}" style="width: 23px">
											{else}
												<img src="{$openIDImageURL}{$name}-sign-in.png" alt="{$name}">
											{/if}
											<span class="ml-1">
												{if isset($customBtnTxt)}
													{$customBtnTxt}
												{else}
													{{translate key="plugins.generic.openid.select.provider.$name"}}
												{/if}
											</span>
										</div>
									</a>
								</div>
							{else}
								<div class="btn btn-outline-dark btn-block mb-1 text-left">
									<a href="{$url}" style="color: inherit !important;">
										<div>
											<img src="{$openIDImageURL}{$name}-sign-in.png" alt="{$name}"/>
											<span class="ml-1">{{translate key="plugins.generic.openid.select.provider.$name"}}</span>
										</div>
									</a>
								</div>
							{/if}
						{/foreach}
					</li>
				{/if}
			</ul>
		</div>
	</div>
</div><!-- .page -->
{include file="frontend/components/footer.tpl"}
