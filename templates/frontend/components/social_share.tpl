{**
 * templates/frontend/components/social_share.tpl
 *
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display social share icons on article details page
 *
 *}
<div class="row article-social-share">
    <!-- Sharingbutton Zotero -->
    <div class="col-2">
        <a class="text-center"
           href="javascript:var d=document,s=d.createElement('script');s.src='https://www.zotero.org/bookmarklet/loader.js';(d.body?d.body:d.documentElement).appendChild(s);void(0);"
           target="_blank" rel="noopener" aria-label="">
            <div class="resp-sharing-button resp-sharing-button--zotero font-weight-bold" data-toggle="tooltip" data-placement="top" title="Zotero">
                Z
            </div>
        </a>
    </div>
    <!-- Sharingbutton Mendeley -->
    <div class="col-2">
        <a class="text-center"
           href="https://www.mendeley.com/import/?url={$url|escape:'url'}"
           target="_blank" rel="noopener" aria-label="">
            <div class="resp-sharing-button resp-sharing-button--mendeley" data-toggle="tooltip" data-placement="top" title="Mendeley">
                <i class="fab fa-mendeley"></i>
            </div>
        </a>
    </div>
    <!-- Sharingbutton E-Mail -->
    <div class="col-2">
        <a class="text-center"
           href="mailto:?subject={$title|escape:'url'}&amp;body={$url|escape:'url'}"
           target="_self"
           rel="noopener" aria-label="">
            <div class="resp-sharing-button resp-sharing-button--email" data-toggle="tooltip" data-placement="top" title="Mail">
                <i class="far fa-envelope align-middle"></i>
            </div>
        </a>
    </div>
    <!-- Sharingbutton Twitter -->
    <div class="col-2">
        <a class="text-center"
           href="https://twitter.com/intent/tweet/?text={$title|escape:'url'}&amp;url={$url|escape:'url'}"
           target="_blank" rel="noopener" aria-label="">
            <div class="resp-sharing-button resp-sharing-button--twitter" data-toggle="tooltip" data-placement="top" title="Twitter">
                <i class="fab fa-twitter"></i>
            </div>
        </a>
    </div>
    <!-- Sharingbutton Facebook -->
    <div class="col-2">
        <a class="text-center" href="https://facebook.com/sharer/sharer.php?u={$url|escape:'url'}" target="_blank" rel="noopener"
           aria-label="">
            <div class="resp-sharing-button  resp-sharing-button--facebook" data-toggle="tooltip" data-placement="top" title="Facebook">
                <i class="fab fa-facebook-f"></i>
            </div>
        </a>
    </div>
    <!-- Sharingbutton LinkedIn -->
    <div class="col-2">
        <a class="text-center"
           href="https://www.linkedin.com/shareArticle?mini=true&amp;url={$url|escape:'url'}&amp;title={$title|escape:'url'}&amp;summary={$title|escape:'url'}&amp;source={$url|escape:'url'}"
           target="_blank" rel="noopener" aria-label="">
            <div class="resp-sharing-button resp-sharing-button--linkedin" data-toggle="tooltip" data-placement="top" title="LinkedIn">
                <i class="fab fa-linkedin-in"></i>
            </div>
        </a>
    </div>
    {*    <!-- Sharingbutton XING -->
        <div class="col">
            <a class="text-center"
               href="https://www.xing.com/app/user?op=share;url={$url|escape:'url'};title={$title|escape:'url'}"
               target="_blank" rel="noopener" aria-label="">
                <div class="resp-sharing-button resp-sharing-button--xing">
                    <i class="fab fa-xing"></i>
                </div>
            </a>
        </div>*}
</div>