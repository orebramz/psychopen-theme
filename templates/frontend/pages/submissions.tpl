{**
 * templates/frontend/pages/submissions.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the editorial team.
 *
 * @uses $currentContext Journal|Press The current journal or press
 * @uses $submissionChecklist array List of requirements for submissions
 *}
{include file="frontend/components/header.tpl" pageTitle="about.submissions"}
<div id="main-content" class="page page_submissions">
    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.submissions"}
    {* Page Title *}
    <div class="mb-1 mt-4">
        <h1>{translate key="about.submissions"}</h1>
    </div>
    {* /Page Title *}
    {* Login/register prompt *}
    {if $isUserLoggedIn}
        {capture assign="newSubmission"}<a href="{url page="submission" op="wizard"}">{translate key="about.onlineSubmissions.newSubmission"}</a>{/capture}
        {capture assign="viewSubmissions"}<a href="{url page="submissions"}">{translate key="about.onlineSubmissions.viewSubmissions"}</a>{/capture}
        <div class="card">
            <div class="card-body">
                {translate key="about.onlineSubmissions.submissionActions" newSubmission=$newSubmission viewSubmissions=$viewSubmissions}
            </div>
        </div>
    {else}
        {capture assign="login"}<a href="{url page="login"}">{translate key="about.onlineSubmissions.login"}</a>{/capture}
        {capture assign="register"}<a href="{url page="user" op="register"}">{translate key="about.onlineSubmissions.register"}</a>{/capture}
        <div class="card">
            <div class="card-body">
                {translate key="about.onlineSubmissions.registrationRequired" login=$login register=$register}
            </div>
        </div>
    {/if}
    {* Submission Checklist *}
    {if $submissionChecklist}
        <div class="card default-card-layout mt-1">
            <div class="card-body">
                <h2 class="card-title font-weight-bold">
                    {translate key="about.submissionPreparationChecklist"}
                    {include file="frontend/components/editLink.tpl" page="management" op="settings" path="publication" anchor="submissionStage" sectionTitleKey="about.submissionPreparationChecklist"}
                </h2>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item font-weight-bold text-danger">
                        {translate key="about.submissionPreparationChecklist.description"}
                    </li>
                    {foreach from=$submissionChecklist item=checklistItem}
                        <li class="list-group-item">
                            <div class="row">
                                <div class="col-auto">
                                    <i class="fas fa-check" aria-hidden="true"></i>
                                </div>
                                <div class="col">
                                    {$checklistItem.content|nl2br}
                                </div>
                            </div>
                        </li>
                    {/foreach}
                </ul>
            </div>
        </div>
    {/if}
    {* /Submission Checklist *}
    {* Author Guidelines *}
    {if $currentJournal->getLocalizedSetting('authorGuidelines')}
        <div class="card default-card-layout mt-4">
            <div class="card-body">
                <h2 class="card-title font-weight-bold">
                    {translate key="about.authorGuidelines"}
                    {include file="frontend/components/editLink.tpl" page="management" op="settings" path="journal" anchor="guidelines" sectionTitleKey="about.authorGuidelines"}
                </h2>
                {$currentJournal->getLocalizedSetting('authorGuidelines')}
            </div>
        </div>
    {/if}
    {* /Author Guidelines *}
    {* Copyright Notice *}
    {if $currentJournal->getLocalizedSetting('copyrightNotice')}
        <div class="card default-card-layout mt-4">
            <div class="card-body">
                <h2 class="card-title font-weight-bold">
                    {translate key="about.copyrightNotice"}
                    </span>{include file="frontend/components/editLink.tpl" page="management" op="settings" path="journal" anchor="policies" sectionTitleKey="about.copyrightNotice"}
                </h2>
                {$currentJournal->getLocalizedSetting('copyrightNotice')}
            </div>
        </div>
    {/if}
    {* /Copyright Notice *}
</div><!-- .page -->
{include file="frontend/components/footer.tpl"}
