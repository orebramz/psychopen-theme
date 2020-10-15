{**
 * templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2003-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common site frontend footer.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}
</main>
{* Sidebar *}
{if $sidebarEnabled}
    {include file="frontend/components/sidebar.tpl"}
{/if}
</div><!-- row -->
</div><!-- pkp_structure_content -->
<footer class="pkp_structure_footer">
    <div class="container footer-container">
        <div class="row">
            <div class="col-12 col-md-6 col-lg mb-2 mt-3 justify-content-lg-center">
                <div>
                    {if $printIssn}
                        <div>{translate|escape key="plugins.themes.psychOpen.footer.issn"}&nbsp;{translate|escape key="plugins.themes.psychOpen.footer.print"}
                            :&nbsp;&nbsp;{$printIssn|escape}</div>
                    {/if}
                    {if $onlineIssn}
                        <div>{translate|escape key="plugins.themes.psychOpen.footer.issn"}&nbsp;{translate|escape key="plugins.themes.psychOpen.footer.online"}
                            :&nbsp;{$onlineIssn|escape}</div>
                    {/if}
                    <div class="mt-3">
                        <div class="row">
                            <div class="col">
                                <a href="https://creativecommons.org/licenses/by/4.0/" target="_blank" rel="noreferrer">
                                    <img style="max-height: 30px" src="https://mirrors.creativecommons.org/presskit/buttons/88x31/svg/by.svg" alt="CC BY Image">
                                </a>
                            </div>
                            <div class="col">
                                <img style="max-height: 30px" src="{$imageURL}open_access.png" alt="Open Access">
                            </div>
                        </div>
                        <div class="small">{translate|escape key="plugins.themes.psychOpen.footer.license.pre"}
                            <a href="https://creativecommons.org/licenses/by/4.0/" target="_blank" rel="noreferrer">{translate|escape key="plugins.themes.psychOpen.footer.license.link"}</a>
                        </div>
                    </div>
                </div>
            </div>
            {assign var="loadFooterMenu" value={loadFooterMenu footerMenuTitle="Footer"}}
            {if $loadFooterMenu && $footerMenu}
                <div class="col-12 col-md-6 col-lg mb-2 mt-3 d-flex justify-content-lg-center">

                    <div>
                        <h2>{translate|escape key="plugins.themes.psychOpen.footer.links"}</h2>
                        <ul id="footermenu">
                            {foreach from=$footerMenu item="itm"}
                                {if !empty($itm->getUrl()) && !empty($itm->getLocalizedTitle())}
                                    <li class="mb-1"><a href="{$itm->getUrl()}" target="_blank" rel="noreferrer">{$itm->getLocalizedTitle()}</a></li>
                                {elseif !empty($itm->getPath()) && !empty($itm->getLocalizedTitle())}
                                    <li class="mb-1"><a href="{url page=$itm->getPath()}">{$itm->getLocalizedTitle()}</a></li>
                                {else}
                                    {*<li>{$itm->getLocalizedTitle()} - {$itm->getType()}</li>*}
                                {/if}
                            {/foreach}
                        </ul>
                    </div>

                </div>
            {/if}
            <div class="col-12 col-md-6 col-lg mb-2 mt-3 d-flex justify-content-lg-center">
                {if $supportName || $supportPhone || $supportEmail}
                    <div>
                        <h2>
                            {translate key="about.contact.supportContact"}
                        </h2>
                        <div>
                            {$supportName|escape}
                        </div>
                        {if $supportPhone}
                            <div>
                                <i class="fas fa-phone"></i>&nbsp;{$supportPhone|escape}
                            </div>
                        {/if}
                        {if $supportEmail}
                            <div>
                                <i class="fas fa-envelope"></i>
                                <a href="mailto:{$supportEmail|escape}">
                                    {$supportEmail|escape}
                                </a>
                            </div>
                        {/if}
                    </div>
                {/if}
            </div>
            {* Primary contact *}
            <div class="col-12 col-md-6 col-lg mb-2 mt-3 d-flex justify-content-lg-center">
                {if $contactTitle || $contactName || $contactAffiliation || $contactPhone || $contactEmail}
                    <div>
                        <h2>{translate key="about.contact.principalContact"}</h2>
                        <div>{$contactName|escape}</div>
                        <div>{$contactTitle|escape}</div>
                        <div>{$contactAffiliation|strip_unsafe_html}</div>
                        {if $contactPhone}
                            <div><i class="fas fa-phone"></i>&nbsp;{$contactPhone|escape}</div>
                        {/if}
                        {if $contactEmail}
                            <div>
                                <i class="fas fa-envelope"></i>
                                <a href="mailto:{$contactEmail|escape}">
                                    {$contactEmail|escape}
                                </a>
                            </div>
                        {/if}
                    </div>
                {/if}
            </div>
        </div>
        {if $pageFooter}
            <div class="row">
                <div class="col mb-2">
                    {$pageFooter|regex_replace:"/(<p>|<p [^>]*>|<\\/p>)/":""}
                </div>
            </div>
        {/if}
    </div> <!-- .row -->
</footer><!-- .container -->
</div><!-- pkp_structure_page .footer-->
{load_script context="frontend" scripts=$scripts}
{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
