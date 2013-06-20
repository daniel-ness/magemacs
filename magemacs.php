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

    protected function _getModelClassName($model)
    {
        if(!$instance = Mage::getModel($model)) {
            print("'$model' is not a valid entity");
            exit(1);
        }

        return get_class($instance);
    }

    public function run()
    {
        if(isset($this->_args['version'])) {
            echo $this->_checkVersion();
        } elseif(isset($this->_args['model'])) {
            echo $this->_getModelClassName($this->_args['model']);
        }
    }

}

$x = new Magemacs_Shell;
$x->run();