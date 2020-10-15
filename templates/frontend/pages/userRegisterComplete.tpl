{**
 * templates/frontend/pages/userRegisterComplete.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2000-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief A landing page displayed to users upon successful registration
 *}
{include file="frontend/components/header.tpl" pageTitle="user.register"}
<div id="main-content">
    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.register"}
    {translate key="user.login.registrationComplete.instructions"}
    <ul class="list-group list-group-flush mt-4">
        {if array_intersect(array(ROLE_ID_MANAGER, ROLE_ID_SUB_EDITOR, ROLE_ID_ASSISTANT, ROLE_ID_REVIEWER), (array)$userRoles)}
            <li class="list-group-item">
                <a href="{url page="submissions"}">
                    {translate key="user.login.registrationComplete.manageSubmissions"}
                </a>
            </li>
        {/if}
        {if $currentContext}
            <li class="list-group-item">
                <a href="{url page="submission" op="wizard"}">
                    {translate key="user.login.registrationComplete.newSubmission"}
                </a>
            </li>
        {/if}
        <li class="list-group-item">
            <a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="profile"}">
                {translate key="user.editMyProfile"}
            </a>
        </li>
        <li class="list-group-item">
            <a href="{url page="index"}">
                {translate key="user.login.registrationComplete.continueBrowsing"}
            </a>
        </li>
    </ul>
</div>
{include file="frontend/components/footer.tpl"}
