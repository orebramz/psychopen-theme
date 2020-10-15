<?php

/**
 * Class XML_Parser
 */
class XML_Parser
{
    private $xml_data;
    private $xpath_array = array(
        "year" => "//article-meta/pub-date[@pub-type='epub']/year",
        "title" => "//article-meta/title-group/alt-title[@specific-use='APA-reference-style']",
        "journalTitle" => "//journal-meta/journal-title-group/journal-title",
        "elocId" => "//article-meta/elocation-id",
        "volume" => "//article-meta/volume",
        "doi" => "//article-meta/article-id[@pub-id-type='doi']",
        "authors" => "//article-meta/contrib-group/contrib[@contrib-type='author']",
        "supplements" => "//back/sec[@sec-type='supplementary-material']/ref-list[@content-type='supplementary-material']/ref",
    );

    public function getXMLDataArray()
    {
        if (!is_null($this->xml_data))
            return $this->xml_data;
        else
            return null;
    }

    public function buildSupplementList()
    {
        return $this->xml_data["supplements"];
    }


    public function buildAPACite()
    {
        if (!is_null($this->xml_data)) {
            $return_string = "";
            $count = 0;
            $authors = $this->xml_data["authors"];
            foreach ($authors as $author) {
                $return_string .= $author[0];
                $return_string .= ", ";
                $return_string .= $this->buildAPAAuthorGiven($author[1]);
                if (sizeof($authors) > $count + 2) {
                    $return_string .= ", ";
                } else if (sizeof($authors) == $count + 2) {
                    if ($this->xml_data["locale"] == 'en_US')
                        $return_string .= ",";
                    $return_string .= " & ";
                }
                $count++;
            }
            $return_string .= ' (' . $this->xml_data["year"] . '). ';
            $return_string .= $this->xml_data["title"] . '. ';
            $return_string .= '<span style="font-style: italic">';
            $return_string .= $this->xml_data["journalTitle"] . ', ';
            $return_string .= $this->xml_data["volume"];
            if ($this->xml_data["elocId"])
                $return_string .= ', Article ' . $this->xml_data["elocId"] . '.';
            $return_string .= '</span>';
            $return_string .= ' https://doi.org/' . $this->xml_data["doi"];
            return $return_string;
        }
        return null;
    }

    /**
     * @param $xml_url
     * @param $loc
     * @return bool true if XML data was successfully loaded, otherwise false
     */
    public function loadXML($xml_url, $loc)
    {
        $this->xml_data = array();
        $fileContents = file_get_contents($xml_url);
        $fileContents = str_ireplace(array('&nbsp;'), array(' '), $fileContents);
        $fileContents = preg_replace('/&(?!#?[a-z0-9]+;)/', '&amp;', $fileContents);
        $xml = simplexml_load_string($fileContents);
        $this->xml_data["locale"] = $loc;
        foreach ($this->xpath_array as $k => $v) {
            if ($k == 'authors') {
                $val = $this->getAuthors($xml, $v);
                $this->xml_data[$k] = $val;
            } else if ($k == 'supplements') {
                $suppList = $this->getSupplementaryData($xml, $v);
                $this->xml_data[$k] = $suppList;
            } else {
                $val = $this->getSingleValueFromXML($xml, $v);
                $this->xml_data[$k] = $val;
            }
        }
        if (sizeof($this->xml_data) > 0)
            return true;
        return false;
    }


    private function getAuthors($xml, $xpath)
    {
        $ret = array();
        foreach ($xml->xpath($xpath) as $child) {
            $author = array($child->name->surname, $child->name->{'given-names'});
            array_push($ret, $author);
        }
        return $ret;
    }

    private function getSingleValueFromXML($xml, $xpath)
    {
        $data = $xml->xpath($xpath);
        if (sizeof($data) == 1) {
            return $data[0];
        } else {
            return null;
        }
    }


    private function buildAPAAuthorGiven($givenName)
    {
        $ret_name = "";
        if (!empty($givenName)) {
            if (strpos($givenName, " ") !== false) {
                $names = explode(" ", $givenName);
                $count = 0;
                foreach ($names as $name) {
                    if (!empty($name)) {
                        if ($count > 0)
                            $ret_name .= " ";
                        $count++;
                        $ret_name .= substr($name, 0, 1) . '.';
                    }
                }
            } else if (strpos($givenName, "-") !== false) {
                $names = explode("-", $givenName);
                $count = 0;
                foreach ($names as $name) {
                    if (!empty($name)) {
                        if ($count > 0)
                            $ret_name .= "-";
                        $count++;
                        $ret_name .= substr($name, 0, 1) . '.';
                    }
                }
            } else {
                $ret_name .= substr($givenName, 0, 1) . '.';
            }
        }
        return $ret_name;
    }

    /**
     * @param SimpleXMLElement $xml
     * @param $v
     * @return array
     */
    public function getSupplementaryData(SimpleXMLElement $xml, $v)
    {
        $suppList = array();
        foreach ($xml->xpath($v) as $child) {
            $supp = array();
            $supp['title'] = $child->{'mixed-citation'}->{'article-title'};
            if ($supp['title'] == null || $supp['title'] == '')
                $supp['title'] = $child->{'mixed-citation'}->{'source'};
            $titlePost = $child->{'mixed-citation'};
            if ($titlePost != null) {
                $titlePost = str_replace(array("(", ")", ".", ","), "", $titlePost);
                $supp['title'] .= $titlePost;
            }
            $supp['year'] = $child->{'mixed-citation'}->year[0];
            $authors = $child->{'mixed-citation'}->{'person-group'}->name;
            $authorString = '';
            $toEnd = count($authors);
            foreach ($authors as $author) {
                $authorString .= $author->{'surname'} . ' ' . $author->{'given-names'};
                if (0 !== --$toEnd)
                    $authorString .= ', ';
            }
            $supp['authors'] = $authorString;
            $supp['ext-link-type'] = $child->{'mixed-citation'}->{'ext-link'}['ext-link-type'];
            $supp['ext-link'] = $child->{'mixed-citation'}->{'ext-link'};
            $supp['pub-id-type'] = $child->{'mixed-citation'}->{'pub-id'}['pub-id-type'];
            $supp['pub-id'] = $child->{'mixed-citation'}->{'pub-id'};
            $suppList[] = $supp;
        }
        return $suppList;
    }


}
