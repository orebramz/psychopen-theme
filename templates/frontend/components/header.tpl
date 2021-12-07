{**
 * lib/pkp/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site header.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}
{assign var="showingLogo" value=true}
{if $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
    {assign var="showingLogo" value=false}
{/if}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{strip}
    {if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
    <head>
        {if $pageTitle && $pageTitle=='common.search'}
            <meta name="robots" content="noindex">
        {/if}
        {include file="frontend/components/headerHead.tpl"}
    </head>
{/strip}
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}">
<div class="pkp_structure_page">
    <nav id="accessibility-nav" class="sr-only">
        <div id="accessible-menu-label">
            {translate|escape key="plugins.themes.bootstrap3.accessible_menu.label"}
        </div>
        <ul>
            <li>
                <a href="#mainNavbar">{translate|escape key="plugins.themes.bootstrap3.accessible_menu.main_navigation"}</a>
            </li>
            <li>
                <a href="#main-content">{translate|escape key="plugins.themes.bootstrap3.accessible_menu.main_content"}</a>
            </li>
            <li><a href="#sidebar">{translate|escape key="plugins.themes.bootstrap3.accessible_menu.sidebar"}</a></li>
        </ul>
    </nav>
    <header id="headerNavigationContainer">
        <div class="container-fluid">
            <div id="psychOpenPageHeader" class="row align-items-center">
                <div class="col-12 col-sm-auto mb-3 mb-sm-0">
                    <a class="" href="https://www.psychOpen.eu">
                        <img id="psychOpenLogo" src="https://static.wixstatic.com/media/60b422_ce009b52dd7f43709d5d3dbbbd76dd9d.png/v1/fill/w_306,h_175,al_c,q_85,usm_0.66_1.00_0.01/60b422_ce009b52dd7f43709d5d3dbbbd76dd9d.webp" alt="Ogeesimage"/>
                    </a>
                </div>
                <div class="col-auto exploreLinks">
                    <div class="float-md-right float-xl-left">
                        <a href="https://https://www.ogeesinstitute.edu.ng/">Explore Ogees Institute</a>
                    </div>
                </div>
                <div class="col">
                </div>
                <div class="col-12 col-sm-auto" id="navigationUserActions">
                    <div class="row float-xl-right float-lg-right float-md-right float-sm-right">
                        {if $currentJournal && sizeof($currentJournal->getSupportedLocaleNames())>1}
                            <div class="col-auto">
                                <div id="languagePicker">
                                    <div class="dropdown">
                                        <button class="btn btn-sm btn-outline-light dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false" aria-label="{translate key="plugins.themes.psychOpen.aria.lang.select"}">
                                            {translate key="plugins.themes.psychOpen.header.lang.selected"}
                                        </button>
                                        <div class="dropdown-menu dropdown-menu-right">
                                            {foreach from=$currentJournal->getSupportedLocaleNames() item=itm key=localekey}
                                                {if $localekey != $currentLocale}
                                                    <a class="dropdown-item"
                                                       href="{url router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path={$localekey} source=$smarty.server.REQUEST_URI}">
                                                        {$itm}
                                                    </a>
                                                {/if}
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {/if}
                        <div class="col-auto">
                            <a class="btn btn-sm btn-outline-light" href="{url page="about" op="submissions"}">{translate key="plugins.themes.psychOpen.submission.new"}</a>
                        </div>
                        <nav class="col" aria-label="{translate|escape key="common.navigation.user"}">
                            {load_menu name="user" id="navigationUser" ulClass="nav" liClass="nav-item" }
                        </nav>
                    </div>
                </div>
            </div><!-- .row -->
        </div><!-- .container-fluid -->
        <div class="container-fluid {if $requestedPage=='index' || $requestedPage==''}overwriteHeaderLogo{/if}" id="pageHeaderLogo">
            <div class="container logo-container">
                {* Logo or site title. Only use <h1> heading on the homepage.
                   Otherwise that should go to the page title. *}
                <div class="site-name">
                    {if $currentJournal && $multipleContexts}
                        {*{assign var="homeUrl" value={url  journal="index" router=$smarty.const.ROUTE_PAGE}}*}
                        {assign var="homeUrl" value={url  page="index" router=$smarty.const.ROUTE_PAGE}}
                    {else}
                        {assign var="homeUrl" value={url  page="index" router=$smarty.const.ROUTE_PAGE}}
                    {/if}
                    <a href="{$homeUrl}" class="">
                        <img src="{$publicFilesDir}/{$headerLogo}"
                             {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"
                             {else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
                    </a>
                </div>
            </div><!-- .container -->
        </div>
    </header><!-- .pkp_structure_head -->
    <nav id="mainNavbar" class="navbar sticky-top navbar-expand-lg navbar-dark" aria-label="{translate|escape key="common.navigation.site"}">
        <div class="container mb-3 mb-sm-0 navbar-container">
            <button class="navbar-toggler ml-4 ml-sm-0" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse ml-4 ml-sm-0" id="navbarSupportedContent">
                {load_menu name="primary" id="main-navigation" ulClass="navbar-nav mr-auto" ilClass="nav-item"}
                <div class="search-box-btn">
                    <i id="searchIcon" class="fa fa-search" aria-hidden="true"></i>
                </div>
            </div>
        </div>
    </nav>
    <div class="search-box sticky-top" style="top: 47px">
        <div class="container search-box-container">
            <form role="search" method="post" action="{url page="search" op="search"}">
                <div class="input-group input-group-sm">
                    <input type="text" placeholder="{translate key="common.search"}" class="form-control search-box-input" name="query" value="{$searchQuery|escape}"
                           aria-label="{translate|escape key="common.searchQuery"}">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-secondary  search-box-input">{translate key="common.search"}</button>
                    </div>
                </div>
                {if $currentJournal}
                    <input type="hidden" name="searchJournal" id="searchJournal" value="{$currentJournal->getId()}">
                {/if}
            </form>
        </div>
    </div>
    {* Wrapper for page content and sidebars *}
    <div class="container pkp_structure_content">
        <div class="row mt-3 mb-3">
            {assign var="sidebarEnabled" value=false scope=global}
            {if $loadSideBar=='index' && ($requestedPage=='index' || $requestedPage=='')}
                {assign var="sidebarEnabled" value=true scope=global}
            {/if}
            <main class="pkp_structure_main {if $sidebarEnabled}col-12 col-sm-12 col-md-12 col-lg-8 col-xl-8{else}col{/if}">
