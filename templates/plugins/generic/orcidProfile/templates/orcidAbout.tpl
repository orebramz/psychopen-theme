{**
 * plugins/generic/orcidProfile/templates/orcidVerify.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2000-2017 John Willinsky
 * Copyright (c) 2018 University Library Heidelberg
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Page template to display from the OrcidHandler to show ORCID verification success or failure.
 *}
{include file="frontend/components/header.tpl" pageTitle="plugins.generic.orcidProfile.about.title"}
<div id="main-content" class="page page_message">
    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="plugins.generic.orcidProfile.about.title"}
    <div class="mb-3">
        <div class="font-weight-bold">{translate key="plugins.generic.orcidProfile.about.title"}</div>
        {translate key="plugins.generic.orcidProfile.about.orcidExplanation"}
    </div>
    <div class="mb-3">
        <div class="font-weight-bold">{translate key="plugins.generic.orcidProfile.about.howAndWhy.title"}</div>
        {translate key="plugins.generic.orcidProfile.about.howAndWhy"}
    </div>
    <div class="mb-3">
        <div class="card-title font-weight-bold">{translate key="plugins.generic.orcidProfile.about.display.title"}</div>
        {translate key="plugins.generic.orcidProfile.about.display"}
    </div>
</div>
{include file="frontend/components/footer.tpl"}
