{**
 * templates/frontend/pages/editorialTeam.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University Library
 * Copyright (c) 2003-2017 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the editorial team.
 *
 * @uses $currentJournal Journal The current journal
 *}
{include file="frontend/components/header.tpl" pageTitle="about.editorialTeam"}

<div id="main-content">
    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="about.editorialTeam"}
    <h1 class="mt-4 mb-4">{translate key="about.editorialTeam"}</h1>
    <div class="mb-5">{$currentJournal->getLocalizedSetting('editorialTeam')}</div>
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
