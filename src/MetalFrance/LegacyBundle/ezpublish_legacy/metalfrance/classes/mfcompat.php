<?php
/**
 * Classe MFCompat
 * Gestion de la compatibilite entre v2 et v3
 * @version 3.0
 * @author Jerome Vieilledent
 * @package metalfrance
 * @subpackage mfcompat
 */
class MFCompat
{
    /**
     * @var MFCompat
     */
    private static $_instance;

    /**
     * @var eZINI
     */
    private $mfINI;

    private function __construct()
    {
        $this->mfINI = eZINI::instance( 'metalfrance.ini' );
    }

    /**
     * Singleton
     */
    public static function getInstance()
    {
        if ( !self::$_instance instanceof MFCompat )
        {
            self::$_instance = new self;
        }

        return self::$_instance;
    }

    /**
     * Retourne l'URL de redirection pour le contenu demande
     * @param $type Type de contenu (chronique, livereport, photos, interview...)
     * @param $id ID du contenu dans la v2
     * @throws InvalidArgumentException
     */
    public static function getRedirectURL( $type, $id )
    {
        $url = null;
        $method = null;
        $compatObject = self::getInstance();
        switch( $type )
        {
            case 'chronique':
                $method = 'getChroniqueURL';
                break;
            case 'livereport':
                $method = 'getLiveReportURL';
                break;
            case 'photos':
                $method = 'getGaleriePhotosURL';
                break;
            case 'interview':
                $method = 'getInterviewURL';
                break;
            default:
                throw new InvalidArgumentException( "Type de contenu '$type' invalide !" );
        }

        return $compatObject->$method( $id );
    }

    /**
     * Retourne l'URL pour la chronique donnee
     * @param $id
     */
    private function getChroniqueURL( $id )
    {
        $class = MFChroniqueMigration::CONTENT_CLASS_CHRONIQUE;
        $params = array(
            'class_filter_array'    => array( $class ),
            'attribute_filter'      => array( array( $class.'/id_v2', '=', $id ) ),
        );
        $result = eZFunctionHandler::executeAlias( 'mfcompat_content', $params);

        if( count( $result ) == 0 )
            throw new RuntimeException( __METHOD__ . " => Chronique v2 #$id introuvable" );

        if( !$result[0] instanceof eZContentObjectTreeNode )
            throw new RuntimeException( __METHOD__ . ' => Noeud invalide' );

        return $result[0]->attribute( 'url_alias' );
    }

    /**
     * Retourne l'URL pour le livereport donne
     * @param $id
     */
    private function getLiveReportURL( $id )
    {
        $class = MFLiveReportMigration::CONTENT_CLASS_LIVE_REPORT;
        $params = array(
            'class_filter_array'    => array( $class ),
            'attribute_filter'      => array( array( $class.'/id_v2', '=', $id ) ),
        );
        $result = eZFunctionHandler::executeAlias( 'mfcompat_content', $params);

        if( count( $result ) == 0 )
            throw new RuntimeException( __METHOD__ . " => Live Report v2 #$id introuvable" );

        if( !$result[0] instanceof eZContentObjectTreeNode )
            throw new RuntimeException( __METHOD__ . ' => Noeud invalide' );

        return $result[0]->attribute( 'url_alias' );
    }

    /**
     * Retourne l'URL pour la galerie photo donnee
     * @param $id
     */
    private function getGaleriePhotosURL( $id )
    {
        $class = MFPhotosMigration::CONTENT_CLASS_GALLERY;
        $params = array(
            'class_filter_array'    => array( $class ),
            'attribute_filter'      => array( array( $class.'/id_v2', '=', $id ) ),
        );
        $result = eZFunctionHandler::executeAlias( 'mfcompat_content', $params);

        if( count( $result ) == 0 )
            throw new RuntimeException( __METHOD__ . " => Galerie photos v2 #$id introuvable" );

        if( !$result[0] instanceof eZContentObjectTreeNode )
            throw new RuntimeException( __METHOD__ . ' => Noeud invalide' );

        return $result[0]->attribute( 'url_alias' );
    }

    /**
     * Retourne l'URL pour l'interview donnee
     * @param $id
     */
    private function getInterviewURL( $id )
    {
        $class = MFInterviewsMigration::CONTENT_CLASS_INTERVIEW;
        $params = array(
            'class_filter_array'		=> array( $class ),
            'attribute_filter'			=> array( array( $class.'/id_v2', '=', $id ) )
        );
        $result = eZFunctionHandler::executeAlias( 'mfcompat_content', $params);

        if( count( $result ) == 0 )
            throw new RuntimeException( __METHOD__ . " => Interview v2 #$id introuvable" );

        if( !$result[0] instanceof eZContentObjectTreeNode )
            throw new RuntimeException( __METHOD__ . ' => Noeud invalide' );

        return $result[0]->attribute( 'url_alias' );
    }

    /**
     * Retourne l'URL de redirection pour l'image demandee
     * Seules les photos et les interviews sont supportées
     * @param $type Type de contenu (photos, interview)
     * @param $name Nom de l'image dans la v2
     * @throws InvalidArgumentException
     */
    public static function getRedirectImage( $type, $name )
    {
        $url = null;
        $method = null;
        $compatObject = self::getInstance();
        switch( $type )
        {
            case 'photos':
                $method = 'getPhotoImage';
                break;
            case 'interview':
                $method = 'getInterviewImage';
                break;
            default:
                throw new InvalidArgumentException( "Type de contenu '$type' invalide !" );
        }

        return $compatObject->$method( $name );
    }

    /**
     * Retourne l'URL de l'image venant d'un contenu "photo"
     * @param Nom de l'image $name
     * @throws RuntimeException
     */
    private function getPhotoImage( $name )
    {
        $params = array(
            'parent_node_id'		=> 2,
            'attribute_filter'		=> array( array( 'name', '=', $name ) )
        );
        $result = eZFunctionHandler::executeAlias( 'mfcompat_image', $params);

        if( count( $result ) == 0 )
            throw new RuntimeException( __METHOD__ . " => L'image \"$name\" introuvable" );

        if( !$result[0] instanceof eZContentObjectTreeNode )
            throw new RuntimeException( __METHOD__ . ' => Noeud invalide' );

       $dm = $result[0]->dataMap();
       $imageAlias = $dm['image']->content()->attribute( 'large' );

       return $imageAlias['url'];
    }

    private function getInterviewImage( $name )
    {
        $importINI = eZINI::instance( 'sqliimport.ini' );

        $params = array(
            'parent_node_id'		=> $importINI->variable( 'mfmigrationinterviews-HandlerSettings', 'ImagesParentNodeID' ),
            'attribute_filter'		=> array( array( 'name', '=', $name ) )
        );
        $result = eZFunctionHandler::executeAlias( 'mfcompat_image', $params);

        if( count( $result ) == 0 )
            throw new RuntimeException( __METHOD__ . " => L'image \"$name\" introuvable" );

        if( !$result[0] instanceof eZContentObjectTreeNode )
            throw new RuntimeException( __METHOD__ . ' => Noeud invalide' );

       $dm = $result[0]->dataMap();
       $imageAlias = $dm['image']->content()->attribute( 'large' );

       return $imageAlias['url'];
    }
}