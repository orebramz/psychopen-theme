{**
 * templates/frontend/components/headerHead.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2000-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site header <head> tag and contents.
 *}

<meta charset="{$defaultCharset|escape}"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
{if $requestedPage=='article' && $requestedOp=='view' && $article && $currentJournal}
    <link rel="canonical" href="{url page="article" op="view" path=$article->getBestArticleId($currentJournal)}"/>
{/if}
{strip}
    <title>
        {$pageTitleTranslated|strip_tags}
        {if $requestedPage|escape|default:"index" != 'index' && $currentContext && $currentContext->getLocalizedName()}
            | {$currentContext->getLocalizedName()}
        {/if}
    </title>
{/strip}
{load_header context="frontend"}
{load_stylesheet context="frontend"}
{include file="frontend/objects/schema_json_ld.tpl"}
{* google search console verification *}
<meta name="google-site-verification" content="Yz4jEtVVvrbulGhf6a7iZ5EUkRA_2XOlV8NLrU_GVnM"/>
{* Twitter DO-NOT-TRACK enabled *}
<meta name="twitter:dnt" content="on">


