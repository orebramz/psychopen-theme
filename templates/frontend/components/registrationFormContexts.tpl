{**
 * templates/frontend/components/registrationFormContexts.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display role selection for all of the journals/presses on this site
 *
 * @uses $contexts array List of journals/presses on this site
 * @uses $readerUserGroups array Associative array of user groups with reader permissions in each context.
 * @uses $authorUserGroups array Associative array of user groups with author permissions in each context.
 * @uses $reviewerUserGroups array Associative array of user groups with reviewer permissions in each context.
 * @uses $userGroupIds array List group IDs this user is assigned
 *}
{* Only display the context role selection when registration is taking place outside of the context of any one journal/press. *}
{if !$currentContext}
    {* Allow users to register for any journal/press on this site *}
    <div class="card mb-3">
        <div class="card-header font-weight-bold bg-white">
            {translate key="user.register.contextsPrompt"}
        </div>
        <div class="card-body">
            <div id="contextOptinGroup" class="context_optin">
                {foreach from=$contexts item=context}
                    {assign var=contextId value=$context->getId()}
                    <div class="card mb-1">
                        <div class="card-header font-weight-bold bg-white">
                            {$context->getLocalizedName()}
                        </div>
                        <div class="card-body">
                            <div class="card-subtitle">{translate key="user.register.otherContextRoles"}</div>
                            <div class="row mt-2">
                                {foreach from=$readerUserGroups[$contextId] item=userGroup}
                                    {if $userGroup->getPermitSelfRegistration()}
                                        {assign var="userGroupId" value=$userGroup->getId()}
                                        <label class="col-auto">
                                            <input type="checkbox" name="readerGroup[{$userGroupId}]"{if in_array($userGroupId, $userGroupIds)} checked="checked"{/if}>
                                            {$userGroup->getLocalizedName()}
                                        </label>
                                    {/if}
                                {/foreach}
                                {foreach from=$authorUserGroups[$contextId] item=userGroup}
                                    {if $userGroup->getPermitSelfRegistration()}
                                        {assign var="userGroupId" value=$userGroup->getId()}
                                        <label class="col-auto">
                                            <input type="checkbox" name="authorGroup[{$userGroupId}]"{if in_array($userGroupId, $userGroupIds)} checked="checked"{/if}>
                                            {$userGroup->getLocalizedName()}
                                        </label>
                                    {/if}
                                {/foreach}
                                {foreach from=$reviewerUserGroups[$contextId] item=userGroup}
                                    {if $userGroup->getPermitSelfRegistration()}
                                        {assign var="userGroupId" value=$userGroup->getId()}
                                        <label class="col-auto">
                                            <input type="checkbox" name="reviewerGroup[{$userGroupId}]"{if in_array($userGroupId, $userGroupIds)} checked="checked"{/if}>
                                            {$userGroup->getLocalizedName()}
                                        </label>
                                    {/if}
                                {/foreach}
                            </div>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    </div>
{/if}
