{**
 * templates/frontend/pages/navigationMenuItemViewContent.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display NavigationMenuItem content
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$title}
<div id="main-content" class="custom-page-content">
    {include file="frontend/components/breadcrumbs.tpl" currentTitle=$title}
    {*<h1 class="mt-4">{$title|escape}</h1>*}
    <div class="mb-5">{$content}</div>
</div><!-- .page -->
{include file="frontend/components/footer.tpl"}
