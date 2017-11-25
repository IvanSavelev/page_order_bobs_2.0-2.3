<?php

/**
 * Class ControllerModulePageOrderBobs front class controller
 *
 * @author  Bobs
 * @license GPL
 */
class ModelExtensionModulePageOrderBobs extends Model
{

    public function getPostLink($order_id, $percent)
    {
        $sql = "SELECT `page_id` FROM `" . DB_PREFIX . "page_order_bobs_description` WHERE `order_id` LIKE " . (int)$order_id;
        $page = $this->db->query($sql);
        $page_id = $page->row['page_id'];
        $sql = "SELECT * FROM `" .
            DB_PREFIX . "page_order_bobs_links`  WHERE `page_id`=" . (int)$page_id . " AND `percent`=" . (int)$percent;
        $links = $this->db->query($sql);
        $array_link = Array();
        foreach ($links->rows as $link) {
            if ($link['percent']) {
                $array_link[$link['type']] = $link['link'];
            }
        }
        return $array_link;
    }


    public function getPage($page_id)
    {
        $sql = "SELECT * FROM `" .
            DB_PREFIX . "page_order_bobs` op
                LEFT JOIN `" .
            DB_PREFIX . "page_order_bobs_description` opd
                ON
                (op.page_id = opd.page_id) WHERE op.page_id=" . (int)$page_id;
        $query = $this->db->query($sql);
        $page = $query->row;
        $sql = "SELECT * FROM `" .
            DB_PREFIX . "page_order_bobs_links` WHERE `page_id`=" . (int)$page_id . " ORDER BY `link_id`";
        $links = $this->db->query($sql);
        $links = $links->rows;
        if(!empty($links))
        {
            $page['links'] = $links;
        }
        return $page;
    }

}


?>