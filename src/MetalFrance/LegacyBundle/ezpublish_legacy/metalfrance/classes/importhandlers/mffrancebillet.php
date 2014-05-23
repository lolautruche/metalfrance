<?php
/**
 * File containing MFFranceBillet
 * @copyright Copyright (C) 2010 - Lolart.net. All rights reserved
 * @licence http://www.gnu.org/licenses/gpl-2.0.txt GNU GPLv2
 * @author Jerome Vieilledent
 * @version 1.0.0
 * @package mfmigration
 * @subpackage importhandlers
 */

/**
 * Handler d'import du flux France Billet
 */
class MFFranceBillet extends SQLIImportAbstractHandler implements ISQLIImportHandler
{
    const CONTENT_CLASS = 'mf_concert_francebillet';

    protected $rowIndex = 0;

    protected $rowCount;

    protected $currentID;

    /**
     * Constructor
     */
    public function __construct( SQLIImportHandlerOptions $options = null )
    {
        parent::__construct( $options );
        $this->remoteIDPrefix = $this->getHandlerIdentifier().'-';
        $this->currentRemoteIDPrefix = $this->remoteIDPrefix;
    }

    /**
     * (non-PHPdoc)
     * @see extension/sqliimport/classes/sourcehandlers/ISQLIImportHandler::initialize()
     */
    public function initialize()
    {
        $xmlUrl = $this->handlerConfArray['XMLStream'];
        $xmlString = eZHTTPTool::getDataByURL( $xmlUrl );

        $xmlOptions = new SQLIXMLOptions( array(
            'xml_string'        => $xmlString,
            'xml_parser'        => 'simplexml'
        ) );
        $xmlParser = new SQLIXMLParser( $xmlOptions );

        // On recherche tous les products dans la catégorie HardRock/Metal (HAR)
        $fullXML = $xmlParser->parse();
        $fullXML->registerXPathNamespace( 'x', $this->handlerConfArray['XMLNS'] );
        $XPath = "//x:product[contains(./x:merchantCategory, '".$this->handlerConfArray['MerchantCategory']."')]";
        $this->dataSource = $fullXML->xpath( $XPath );
    }

    /**
     * (non-PHPdoc)
     * @see extension/sqliimport/classes/sourcehandlers/ISQLIImportHandler::getProcessLength()
     */
    public function getProcessLength()
    {
        if( !isset( $this->rowCount ) )
        {
            $itemLimit = (int)$this->handlerConfArray['ItemLimit'];
            $this->rowCount = $itemLimit > 0 ? $itemLimit : count( $this->dataSource );
        }
        return $this->rowCount;
    }

    /**
     * (non-PHPdoc)
     * @see extension/sqliimport/classes/sourcehandlers/ISQLIImportHandler::getNextRow()
     */
    public function getNextRow()
    {
        if( $this->rowIndex < $this->rowCount )
        {
            $row = $this->dataSource[$this->rowIndex];
            $this->rowIndex++;
        }
        else
        {
            $row = false; // We must return false if we already processed all rows
        }

        return $row;
    }

    /**
     * (non-PHPdoc)
     * @see extension/sqliimport/classes/sourcehandlers/ISQLIImportHandler::process()
     */
    public function process( $row )
    {
        $this->currentID = $row['zupid'];

        $remoteID = 'concert_fb-'.$row['zupid'];
        $reviewOptions = new SQLIContentOptions( array(
            'class_identifier'      => self::CONTENT_CLASS,
            'remote_id'             => $remoteID
        ) );
        $content = SQLIContent::create( $reviewOptions );
        $publisher = SQLIContentPublisher::getInstance();
        $parentLocation = SQLILocation::fromNodeID( $this->handlerConfArray['DefaultParentNodeID'] );

        $content->fields->name = (string)$row->name;
        $content->fields->link = (string)$row->deepLink;
        $timestampFrom = strtotime( (string)$row->validFrom );
        $timestampTo = strtotime( (string)$row->validTo );
        $content->fields->date_from = $timestampFrom;
        $content->fields->date_to = $timestampTo;
        $content->fields->unpublish_date = $timestampTo > 0 ? $timestampTo + 86400 : $timestampFrom + 86400; // Dépublication 1j après la date de fin
        $content->fields->price = (string)$row->price.'|1|1';
        $content->fields->currency = (string)$row->currencyCode;
        $content->fields->image_small = (string)$row->smallImage;
        $content->fields->image_medium = (string)$row->mediumImage;
        $content->fields->image_large = (string)$row->largeImage;
        $content->fields->place = (string)$row->manufacturer.' ('.(string)ucwords( $row->extra2 ).')';
        if( strpos( (string)$row->shippingHandling , '1|0') === 0 ) // Coordonnees GPS indisponibles
        {
            $latitude = '';
            $longitude = '';
        }
        else
        {
            list( $gps1, $gps2, $latitude, $longitude ) = explode( '|', (string)$row->shippingHandling );
        }
        $location = '1|#'.$latitude.'|#'.$longitude.'|#'.(string)$row->longDescription.', '.(string)$row->extra2.', '.(string)$row->description;
        $content->fields->gmap_location = $location;
        $zip = (string)$row->terms;
        $content->fields->zip_code = $zip;
        $content->fields->region = substr( $zip, 0, 2 );
        $content->fields->country = (string)$row->description;

        $content->addLocation( $parentLocation );
        $publisher->publish( $content );

        unset( $content );
    }

    /**
     * (non-PHPdoc)
     * @see extension/sqliimport/classes/sourcehandlers/ISQLIImportHandler::cleanup()
     */
    public function cleanup()
    {
        // Nothing to clean up
        return;
    }

    /**
     * (non-PHPdoc)
     * @see extension/sqliimport/classes/sourcehandlers/ISQLIImportHandler::getHandlerName()
     */
    public function getHandlerName()
    {
        return 'MF France Billet';
    }

    /**
     * (non-PHPdoc)
     * @see extension/sqliimport/classes/sourcehandlers/ISQLIImportHandler::getHandlerIdentifier()
     */
    public function getHandlerIdentifier()
    {
        return 'mffrancebillet';
    }

    /**
     * (non-PHPdoc)
     * @see extension/sqliimport/classes/sourcehandlers/ISQLIImportHandler::getProgressionNotes()
     */
    public function getProgressionNotes()
    {
        return 'Import du concert #'.$this->currentID;
    }
}
