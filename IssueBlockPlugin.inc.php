<?php
import('lib.pkp.classes.plugins.BlockPlugin');

class IssueBlockPlugin extends BlockPlugin
{
    public function getContents($templateMgr, $request = null)
    {
        return $templateMgr->fetch('templates/frontend/blocks/issueBlock.tpl');
    }

    public function getDisplayName()
    {
        return __('plugins.blocks.issues.title');
    }

    public function getDescription()
    {
        return __('plugins.blocks.issues.desc');
    }


}