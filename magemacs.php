class Magemacs_Shell extends Mage_Shell_Abstract
{

    protected function _isEnterprise()
    {
        return Mage::getConfig()->getModuleConfig('Enterprise_Enterprise')
            && Mage::getConfig()->getModuleConfig('Enterprise_AdminGws') 
            && Mage::getConfig()->getModuleConfig('Enterprise_Checkout') 
            && Mage::getConfig()->getModuleConfig('Enterprise_Customer');
    }

    protected function _isProfessional()
    {
        return Mage::getConfig()->getModuleConfig('Enterprise_Enterprise') 
            && !Mage::getConfig()->getModuleConfig('Enterprise_AdminGws') 
            && !Mage::getConfig()->getModuleConfig('Enterprise_Checkout') 
            && !Mage::getConfig ()->getModuleConfig('Enterprise_Customer');
    }

    protected function _isCommunity()
    {
        return !$this->_isEnterprise() && !$this->_isProfessional();
    }

    protected function _checkVersion()
    {
        $edition = "Community";

        if($this->_isEnterprise()) {
            $edition = "Enterprise";
        } elseif($this->_isProfessional()) {
            $edition = "Professional";
        }

        return "$edition " . Mage::getVersion();
    }

    public function run()
    {
        if(isset($this->_args['version'])) {
            echo $this->_checkVersion();
        }
    }
    
}

$x = new Magemacs_Shell;
$x->run();