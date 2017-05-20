<?php
/**
 * Copyright © 2013-2017 Magento, Inc. All rights reserved.
 * See COPYING.txt for license details.
 */
namespace Magento\Customer\Block\Account;

use Magento\Customer\Model\Context;

/**
 * Customer help link
 *
 * @SuppressWarnings(PHPMD.DepthOfInheritance)
 */
class HelpLink extends \Magento\Framework\View\Element\Html\Link
{
    /**
     * Customer session
     *
     * @var \Magento\Framework\App\Http\Context
     */
    protected $httpContext;

    /**
     * @var \Magento\Customer\Model\Url
     */
    protected $_customerUrl;

    /**
     * @var \Magento\Framework\Data\Helper\PostHelper
     */
    protected $_postDataHelper;

    /**
     * @param \Magento\Framework\View\Element\Template\Context $context
     * @param \Magento\Framework\App\Http\Context $httpContext
     * @param \Magento\Customer\Model\Url $customerUrl
     * @param \Magento\Framework\Data\Helper\PostHelper $postDataHelper
     * @param array $data
     */
    public function __construct(
        \Magento\Framework\View\Element\Template\Context $context,
        \Magento\Framework\App\Http\Context $httpContext,
        \Magento\Customer\Model\Url $customerUrl,
        \Magento\Framework\Data\Helper\PostHelper $postDataHelper,
        array $data = []
    ) {
        parent::__construct($context, $data);
        $this->httpContext = $httpContext;
        $this->_customerUrl = $customerUrl;
        $this->_postDataHelper = $postDataHelper;
    }

    /**
     * @return string
     */
    public function getHref()
    {
        return $this->_customerUrl->getHelpUrl();
    }

    /**
     * @return string
     */
    public function getLabel()
    {
        return __('Help');
    }

    /**
     * Retrieve params for post request
     *
     * @return string
     */
    public function getPostParams()
    {
        return $this->_postDataHelper->getPostData($this->getHref());
    }
}
