--
--
--  $Id$
--
--  RDF Mappings
--
--  This file is part of the OpenLink Software Virtuoso Open-Source (VOS)
--  project.
--
--  Copyright (C) 1998-2006 OpenLink Software
--
--  This project is free software; you can redistribute it and/or modify it
--  under the terms of the GNU General Public License as published by the
--  Free Software Foundation; only version 2 of the License, dated June 1991.
--
--  This program is distributed in the hope that it will be useful, but
--  WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
--  General Public License for more details.
--
--  You should have received a copy of the GNU General Public License along
--  with this program; if not, write to the Free Software Foundation, Inc.,
--  51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
--
--

-- install the handlers for supported metadata, keep in sync with xslt/html2rdf.xsl rules
delete from DB.DBA.SYS_RDF_MAPPERS where RM_PATTERN = '(text/html)|(application/atom.xml)|(text/xml)|(application/xml)|(application/rss.xml)' and RM_TYPE = 'MIME';
update DB.DBA.SYS_RDF_MAPPERS set RM_PATTERN = '(http://.*amazon.[^/]+/gp/product/.*)|'||
	    '(http://.*amazon.[^/]+/o/ASIN/.*)|'||
	    '(http://.*amazon.[^/]+/[^/]+/dp/[^/]+/.*)|'||
	    '(http://.*amazon.[^/]+/exec/obidos/ASIN/.*)|' ||
	    '(http://.*amazon.[^/]+/exec/obidos/tg/detail/-/[^/]+/.*)'
	where RM_HOOK = 'DB.DBA.RDF_LOAD_AMAZON_ARTICLE';

update DB.DBA.SYS_RDF_MAPPERS set RM_PATTERN = 'http[s]*://www.facebook.com/.*' where RM_HOOK = 'DB.DBA.RDF_LOAD_FQL';

insert soft DB.DBA.SYS_RDF_MAPPERS (RM_PATTERN, RM_TYPE, RM_HOOK, RM_KEY, RM_DESCRIPTION, RM_ENABLED)
    values ('.*', 'HTTP', 'DB.DBA.RDF_LOAD_HTTP_SESSION', null, 'HTTP in RDF', 0);

insert soft DB.DBA.SYS_RDF_MAPPERS (RM_PATTERN, RM_TYPE, RM_HOOK, RM_KEY, RM_DESCRIPTION, RM_OPTIONS)
    values ('(text/html)|(application/atom.xml)|(text/xml)|(application/xml)|(application/rss.xml)|(application/rdf.xml)',
            'MIME', 'DB.DBA.RDF_LOAD_HTML_RESPONSE', null, 'xHTML and feeds', vector ('get-feeds', 'no', 'add-html-meta', 'no'));

insert soft DB.DBA.SYS_RDF_MAPPERS (RM_PATTERN, RM_TYPE, RM_HOOK, RM_KEY, RM_DESCRIPTION)
    values ('http://farm[0-9]*.static.flickr.com/.*',
            'URL', 'DB.DBA.RDF_LOAD_FLICKR_IMG', null, 'Flickr Images');

insert soft DB.DBA.SYS_RDF_MAPPERS (RM_PATTERN, RM_TYPE, RM_HOOK, RM_KEY, RM_DESCRIPTION)
    values ('(http://.*amazon.[^/]+/gp/product/.*)|'||
	    '(http://.*amazon.[^/]+/o/ASIN/.*)|'||
	    '(http://.*amazon.[^/]+/[^/]+/dp/[^/]+/.*)|'||
	    '(http://.*amazon.[^/]+/exec/obidos/ASIN/.*)|' ||
	    '(http://.*amazon.[^/]+/exec/obidos/tg/detail/-/[^/]+/.*)',
            'URL', 'DB.DBA.RDF_LOAD_AMAZON_ARTICLE', null, 'Amazon articles');

insert soft DB.DBA.SYS_RDF_MAPPERS (RM_PATTERN, RM_TYPE, RM_HOOK, RM_KEY, RM_DESCRIPTION)
    values ('(http://bugs.*)|'||
        '(http://.*/show_bug.cgi?id.*)|'||
        '(http://.*bugzilla.*)|'||
        '(https://bugzilla.*)|'||
        '(https://.*bugzilla.*)',
            'URL', 'DB.DBA.RDF_LOAD_BUGZILLA', null, 'Bugzillas');

insert soft DB.DBA.SYS_RDF_MAPPERS (RM_PATTERN, RM_TYPE, RM_HOOK, RM_KEY, RM_DESCRIPTION)
    values ('.+\.svg\$', 'URL', 'DB.DBA.RDF_LOAD_SVG', null, 'SVG');

insert soft DB.DBA.SYS_RDF_MAPPERS (RM_PATTERN, RM_TYPE, RM_HOOK, RM_KEY, RM_DESCRIPTION)
    values ('(http://cgi.sandbox.ebay.com/.*&item=[A-Z0-9]*&.*)|(http://cgi.ebay.com/.*QQitemZ[A-Z0-9]*QQ.*)',
            'URL', 'DB.DBA.RDF_LOAD_EBAY_ARTICLE', null, 'eBay articles');

insert soft DB.DBA.SYS_RDF_MAPPERS (RM_PATTERN, RM_TYPE, RM_HOOK, RM_KEY, RM_DESCRIPTION)
    values ('.+\.od[ts]\$', 'URL', 'DB.DBA.RDF_LOAD_OO_DOCUMENT', null, 'OO Documents');

insert soft DB.DBA.SYS_RDF_MAPPERS (RM_PATTERN, RM_TYPE, RM_HOOK, RM_KEY, RM_DESCRIPTION)
    values ('http://local.yahooapis.com/MapsService/V1/trafficData.*',
            'URL', 'DB.DBA.RDF_LOAD_YAHOO_TRAFFIC_DATA', null, 'Yahoo Traffic Data');


insert soft DB.DBA.SYS_RDF_MAPPERS (RM_PATTERN, RM_TYPE, RM_HOOK, RM_KEY, RM_DESCRIPTION)
    values ('.+\.ics\$', 'URL', 'DB.DBA.RDF_LOAD_ICAL', null, 'iCalendar');

insert soft DB.DBA.SYS_RDF_MAPPERS (RM_PATTERN, RM_TYPE, RM_HOOK, RM_KEY, RM_DESCRIPTION, RM_OPTIONS)
    values ('http[s]*://www.facebook.com/.*',
            'URL', 'DB.DBA.RDF_LOAD_FQL', null, 'FaceBook', vector ('secret', '', 'session', ''));

insert soft DB.DBA.SYS_RDF_MAPPERS (RM_PATTERN, RM_TYPE, RM_HOOK, RM_KEY, RM_DESCRIPTION, RM_OPTIONS)
    values ('http://www.freebase.com/view/.*',
            'URL', 'DB.DBA.RDF_LOAD_MQL', null, 'Freebase', vector ());

insert soft DB.DBA.SYS_RDF_MAPPERS (RM_PATTERN, RM_TYPE, RM_HOOK, RM_KEY, RM_DESCRIPTION, RM_ENABLED)
    values ('.*', 'MIME', 'DB.DBA.RDF_LOAD_DAV_META', null, 'WebDAV Metadata', 1);


insert soft DB.DBA.SYS_RDF_MAPPERS (RM_PATTERN, RM_TYPE, RM_HOOK, RM_KEY, RM_DESCRIPTION)
    values ('http://.*.wikipedia.org.*',
            'URL', 'DB.DBA.RDF_LOAD_WIKIPEDIA_ARTICLE', null, 'Wikipedia');

insert soft DB.DBA.SYS_RDF_MAPPERS (RM_PATTERN, RM_TYPE, RM_HOOK, RM_KEY, RM_DESCRIPTION)
    values ('http://finance.yahoo.com/q\\?s=.*',
            'URL', 'DB.DBA.RDF_LOAD_YAHOO_STOCK_DATA', null, 'Yahoo Finance');

-- we do default http & html handler first of all
update DB.DBA.SYS_RDF_MAPPERS set RM_ID = 0 where RM_HOOK = 'DB.DBA.RDF_LOAD_HTTP_SESSION';
update DB.DBA.SYS_RDF_MAPPERS set RM_ID = 1 where RM_HOOK = 'DB.DBA.RDF_LOAD_HTML_RESPONSE';
update DB.DBA.SYS_RDF_MAPPERS set RM_ID = 2048 where RM_HOOK = 'DB.DBA.RDF_LOAD_DAV_META';
update DB.DBA.SYS_RDF_MAPPERS set RM_ENABLED = 1 where RM_ENABLED is null;

--
-- The GRDDL filters
-- This keeps all microformat filters
-- Every of these is called inside XHTML mapper
--
EXEC_STMT(
'create table DB.DBA.OAI_SERVERS (
    OS_ID	  integer identity,
    OS_SERVER 	  varchar,
    OS_URN_PATTERN varchar,
    OS_ENABLED 	  int default 0,
    primary key (OS_ID, OS_SERVER)
)', 0)
;

EXEC_STMT(
'create table DB.DBA.SYS_GRDDL_MAPPING (
    GM_NAME varchar,
    GM_PROFILE varchar,
    GM_XSLT varchar,
    primary key (GM_NAME)
)
create index SYS_GRDDL_MAPPING_PROFILE on DB.DBA.SYS_GRDDL_MAPPING (GM_PROFILE)', 0)
;

insert replacing DB.DBA.SYS_GRDDL_MAPPING (GM_NAME, GM_PROFILE, GM_XSLT)
    values ('eRDF', 'http://purl.org/NET/erdf/profile', registry_get ('_rdf_mappers_path_') || 'xslt/erdf2rdfxml.xsl')
;

insert replacing DB.DBA.SYS_GRDDL_MAPPING (GM_NAME, GM_PROFILE, GM_XSLT)
    values ('RDFa', '', registry_get ('_rdf_mappers_path_') || 'xslt/rdfa2rdfxml.xsl')
;

insert replacing DB.DBA.SYS_GRDDL_MAPPING (GM_NAME, GM_PROFILE, GM_XSLT)
    values ('hCard', 'http://www.w3.org/2006/03/hcard', registry_get ('_rdf_mappers_path_') || 'xslt/hcard2rdf.xsl')
;

insert replacing DB.DBA.SYS_GRDDL_MAPPING (GM_NAME, GM_PROFILE, GM_XSLT)
    values ('hCalendar', 'http://dannyayers.com/microformats/hcalendar-profile', registry_get ('_rdf_mappers_path_') || 'xslt/hcal2rdf.xsl')
;

insert replacing DB.DBA.SYS_GRDDL_MAPPING (GM_NAME, GM_PROFILE, GM_XSLT)
    values ('hReview', 'http://dannyayers.com/micromodels/profiles/hreview', registry_get ('_rdf_mappers_path_') || 'xslt/hreview2rdf.xsl')
;

insert replacing DB.DBA.SYS_GRDDL_MAPPING (GM_NAME, GM_PROFILE, GM_XSLT)
    values ('relLicense', '', registry_get ('_rdf_mappers_path_') || 'xslt/cc2rdf.xsl')
;

insert replacing DB.DBA.SYS_GRDDL_MAPPING (GM_NAME, GM_PROFILE, GM_XSLT)
    values ('XBRL', '', registry_get ('_rdf_mappers_path_') || 'xslt/xbrl2rdf.xsl')
;

insert replacing DB.DBA.SYS_GRDDL_MAPPING (GM_NAME, GM_PROFILE, GM_XSLT)
    values ('HR-XML', '', registry_get ('_rdf_mappers_path_') || 'xslt/hrxml2rdf.xsl')
;

insert replacing DB.DBA.SYS_GRDDL_MAPPING (GM_NAME, GM_PROFILE, GM_XSLT)
    values ('Dublin Core', '', registry_get ('_rdf_mappers_path_') || 'xslt/dc2rdf.xsl')
;

insert replacing DB.DBA.SYS_GRDDL_MAPPING (GM_NAME, GM_PROFILE, GM_XSLT)
    values ('geoURL', '', registry_get ('_rdf_mappers_path_') || 'xslt/geo2rdf.xsl')
;

insert replacing DB.DBA.SYS_GRDDL_MAPPING (GM_NAME, GM_PROFILE, GM_XSLT)
    values ('Google Base', '', registry_get ('_rdf_mappers_path_') || 'xslt/google2rdf.xsl')
;

insert replacing DB.DBA.SYS_GRDDL_MAPPING (GM_NAME, GM_PROFILE, GM_XSLT)
    values ('Ning Metadata', '', registry_get ('_rdf_mappers_path_') || 'xslt/ning2rdf.xsl')
;

insert replacing DB.DBA.SYS_GRDDL_MAPPING (GM_NAME, GM_PROFILE, GM_XSLT)
    values ('XFN Profile', 'http://gmpg.org/xfn/11', registry_get ('_rdf_mappers_path_') || 'xslt/xfn2rdf.xsl')
;

insert replacing DB.DBA.SYS_GRDDL_MAPPING (GM_NAME, GM_PROFILE, GM_XSLT)
    values ('xFolk', '', registry_get ('_rdf_mappers_path_') || 'xslt/xfolk2rdf.xsl')
;

create procedure DB.DBA.XSLT_REGEXP_MATCH (in pattern varchar, in val varchar)
{
  return regexp_match (pattern, val);
}
;

create procedure DB.DBA.XSLT_SPLIT_AND_DECODE (in val varchar, in md int, in pattern varchar)
{
  declare x, ses any;

  declare exit handler for sqlstate '*'
    {
      return xtree_doc ('<results/>');
    };

  x := split_and_decode (val, md, '\0\0'||pattern);
--  dbg_obj_print (val, md, pattern, x);
  ses := string_output ();
  http ('<results>', ses);
  foreach (any elm in x) do
    {
      if (length (elm))
        http (sprintf ('<result><![CDATA[%s]]></result>', elm), ses);
    }
  http ('</results>', ses);
  return xtree_doc (string_output_string (ses));
}
;

create procedure DB.DBA.XSLT_UNIX2ISO_DATE (in val int)
{
  if (val is null)
    return null;
  return  date_iso8601 (dt_set_tz (dateadd ('second', val, dt_set_tz (stringdate ('1970-01-01'), 0)), 0));
}
;

create procedure DB.DBA.XSLT_SHA1_HEX (in val varchar)
{
  return tree_sha1 (val, 1);
}
;

create procedure DB.DBA.XSLT_STR2DATE (in val varchar)
{
  declare ret any;
  ret := null;
  if (val like '[A-Za-z]* [0-9]*')
    {
      declare dt, pos, tmp, v any;
      v := trim (val, '+');
      pos := strchr (v, ' ');
      tmp := subseq (v, 0, pos);
      dt := trim(tmp);
      tmp := trim (subseq (v, pos));
      dt := 'Wee, ' || tmp || ' ' || dt || sprintf (' %d 00:00:00 GMT', year (now ()));
      ret := http_string_date (dt, null, null);
    }
  else
    ret := http_string_date (val, null, null);
  if (ret is not null)
    {
      ret := dt_set_tz (ret, 0);
      ret := date_iso8601 (ret);
    }
  return coalesce (ret, val);
}
;

create procedure DB.DBA.RDF_SPONGE_PROXY_IRI (in uri varchar, in login varchar)
{
  declare cname any;
  declare ret any;
  declare default_host varchar;
  default_host := cfg_item_value (virtuoso_ini_path (), 'URIQA', 'DefaultHost');
  if (default_host is not null)
    cname := default_host;
  else
    {
      cname := sys_stat ('st_host_name');
      if (server_http_port () <> '80')
	cname := cname ||':'|| server_http_port ();
    }
  if (length (login))
    ret := sprintf ('http://%s/proxy?url=%U&force=rdf&login=%U', cname, uri, login);
  else
    ret := sprintf ('http://%s/proxy?url=%U&force=rdf', cname, uri);
  return ret;
}
;

grant execute on DB.DBA.XSLT_REGEXP_MATCH to public;
grant execute on DB.DBA.XSLT_SPLIT_AND_DECODE to public;
grant execute on DB.DBA.XSLT_UNIX2ISO_DATE to public;
grant execute on DB.DBA.XSLT_SHA1_HEX to public;
grant execute on DB.DBA.XSLT_STR2DATE to public;
grant execute on DB.DBA.RDF_SPONGE_PROXY_IRI to public;

xpf_extension ('http://www.openlinksw.com/virtuoso/xslt/:regexp-match', 'DB.DBA.XSLT_REGEXP_MATCH');
xpf_extension ('http://www.openlinksw.com/virtuoso/xslt/:split-and-decode', 'DB.DBA.XSLT_SPLIT_AND_DECODE');
xpf_extension ('http://www.openlinksw.com/virtuoso/xslt/:unix2iso-date', 'DB.DBA.XSLT_UNIX2ISO_DATE');
xpf_extension ('http://www.openlinksw.com/virtuoso/xslt/:sha1_hex', 'DB.DBA.XSLT_SHA1_HEX');
xpf_extension ('http://www.openlinksw.com/virtuoso/xslt/:str2date', 'DB.DBA.XSLT_STR2DATE');
xpf_extension ('http://www.openlinksw.com/virtuoso/xslt/:proxyIRI', 'DB.DBA.RDF_SPONGE_PROXY_IRI');

--create procedure RDF_LOAD_AMAZON_ARTICLE_INIT ()
--{
--  if (__proc_exists ('DB.DBA.AmazonSearchService',0) is not null)
--    return;
--  SOAP_WSDL_IMPORT ('http://soap.amazon.com/schemas3/AmazonWebServices.wsdl');
--}
--;

--RDF_LOAD_AMAZON_ARTICLE_INIT ();

create procedure RDF_MAPPER_XSLT (in xslt varchar, inout xt any, in params any := null)
{
  set_user_id ('dba');
  if (params is null)
    return xslt (xslt, xt);
  else
    return xslt (xslt, xt, params);
};


create procedure RDF_APERTURE_INIT ()
{
  if (__proc_exists ('java_vm_attach', 2) is null)
    {
      delete from DB.DBA.SYS_RDF_MAPPERS where RM_HOOK = 'DB.DBA.RDF_LOAD_BIN_DOCUMENT';
      return;
    }
  set_qualifier ('APERTURE');
  if (not udt_is_available ('APERTURE.DBA.MetaExtractor'))
  {
    declare exit handler for sqlstate '*'
    {
       set_qualifier ('DB');
       return;
    };
    DB.DBA.import_jar (NULL, 'MetaExtractor', 1);
  }
  exec (
'create procedure DB.DBA.RDF_LOAD_BIN_DOCUMENT (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,
    inout _ret_body any, inout aq any, inout ps any, inout _key any, inout opts any)
{
  declare xd, tmp, fn any;
--  if (graph_iri like \'%.odt\' or graph_iri like \'%.ods\')
--    return 0;
  tmp := null;
  declare exit handler for sqlstate \'*\'
    {
      if (length (tmp))
        file_delete (tmp, 1);
      return 0;
    };
  tmp := tmp_file_name (\'rdfm\', \'bin\');
  fn := tmp;
  string_to_file (tmp, _ret_body, -2);
  xd := APERTURE.DBA."MetaExtractor"().getMetaFromFile (fn, 5);
  xd := charset_recode(xd, \'_WIDE_\', \'UTF-8\');
  file_delete (tmp, 1);
--  dbg_printf (\'%s\', xd);
  if (xd is null)
    return 0;
  xd := replace (xd, \'file:\'||tmp, new_origin_uri);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
  return 1;
}');

  insert soft DB.DBA.SYS_RDF_MAPPERS (RM_PATTERN, RM_TYPE, RM_HOOK, RM_KEY, RM_DESCRIPTION)
    values ('(application/octet-stream)|(application/pdf)|(application/mspowerpoint)',
	'MIME', 'DB.DBA.RDF_LOAD_BIN_DOCUMENT', null, 'Binary Files');
  update DB.DBA.SYS_RDF_MAPPERS set RM_ID = 1000 where RM_HOOK = 'DB.DBA.RDF_LOAD_BIN_DOCUMENT';
  set_qualifier ('DB');
}
;

RDF_APERTURE_INIT ()
;

create procedure DB.DBA.RDF_LOAD_HTTP_SESSION (
    in graph_iri varchar,
    in new_origin_uri varchar,
    in dest varchar,
    inout ret_body any,
    inout aq any, inout ps any,
    inout headers any,
    inout opts any)
{
  declare req, resp any;
  declare ses, tmp any;

  declare meth, host, url, proto_ver, stat, resp_ver any;

  ses := string_output ();
  req := headers[0];
  resp := headers[1];

  host := http_request_header (req, 'Host');

  tmp := split_and_decode (req[0], 0, '\0\0 ');
  meth := tmp[0];
  meth := lower (meth);
  meth[0] := meth[0] - 32;

  url := tmp[1];
  proto_ver := substring (tmp[2], 6, 8);

  tmp := rtrim (resp[0], '\r\n');
  tmp := split_and_decode (resp[0], 0, '\0\0 ');
  stat := tmp[1];
  resp_ver := substring (tmp[0], 6, 8);

  http ('<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:http="http://www.w3.org/2006/http#">\n', ses);

  http ('<http:Connection rdf:ID="conn">\n', ses);
  http ('  <http:connectionAuthority>'|| host ||'</http:connectionAuthority>\n', ses);
  http ('    <http:request rdf:parseType="Collection">\n', ses);
  http ('    <http:Request rdf:about="#req0"/>\n', ses);
  http ('  </http:request>\n', ses);
  http ('</http:Connection>\n', ses);

  http ('<http:'|| meth ||'Request rdf:ID="req0">\n', ses);
  http ('  <http:abs_path>'|| url ||'</http:abs_path>\n', ses);
  http ('  <http:version>'|| proto_ver ||'</http:version>\n', ses);
  http ('  <http:header rdf:parseType="Collection">\n', ses);
  -- loop over req from 1 - len
  tmp := '';
  for (declare i int, i := 1; i < length (req); i := i + 1)
    {
      tmp := tmp || trim (req[i], '\r\n') || '\r\n' ;
    }
  tmp := mime_tree (tmp);
  tmp := tmp[0];
  for (declare i int, i := 0; i < length (tmp); i := i + 2)
    {
      http ('<http:MessageHeader>\n', ses);
      http ('  <http:fieldName rdf:resource="http://www.w3.org/2006/http-header#'||lower (tmp[i])||'"/>\n', ses);
      http ('  <http:fieldValue>\n', ses);
      http ('    <http:HeaderElement>\n', ses);
      http ('     <http:elementName>'||tmp[i+1]||'</http:elementName>\n', ses);
      http ('    </http:HeaderElement>\n', ses);
      http ('  </http:fieldValue>\n', ses);
      http ('</http:MessageHeader>\n', ses);
    }


  http ('  </http:header>\n', ses);
  http ('  <http:response rdf:resource="#resp0"/>\n', ses);
  http ('</http:'|| meth ||'Request>\n', ses);

  http ('<http:Response rdf:ID="resp0">\n', ses);
  http ('<http:responseCode rdf:resource="http://www.w3.org/2006/http#'||stat||'"/>\n', ses);
  http ('  <http:version>'||resp_ver||'</http:version>\n', ses);
  http ('  <http:header rdf:parseType="Collection">\n', ses);
  -- loop over resp from 1 - len

  tmp := '';
  for (declare i int, i := 1; i < length (resp); i := i + 1)
    {
      tmp := tmp || trim (resp[i], '\r\n') || '\r\n' ;
    }
  tmp := mime_tree (tmp);
  tmp := tmp[0];
  for (declare i int, i := 0; i < length (tmp); i := i + 2)
    {
      http ('<http:MessageHeader>\n', ses);
      http ('  <http:fieldName rdf:resource="http://www.w3.org/2006/http-header#'||lower (tmp[i])||'"/>\n', ses);
      http ('  <http:fieldValue>\n', ses);
      http ('    <http:HeaderElement>\n', ses);
      http ('     <http:elementName>'||tmp[i+1]||'</http:elementName>\n', ses);
      http ('    </http:HeaderElement>\n', ses);
      http ('  </http:fieldValue>\n', ses);
      http ('</http:MessageHeader>\n', ses);
    }

  http ('  </http:header>\n', ses);
  http ('</http:Response>\n', ses);
  http ('</rdf:RDF>\n', ses);

  tmp := string_output_string (ses);

  DB.DBA.RDF_LOAD_RDFXML (tmp, new_origin_uri, coalesce (dest, graph_iri));

  -- never stop the rest of handlers
  return 0;
}
;

create procedure FB_SIG (in params any, in secret any)
{
  declare arr, pars, str any;
  arr := split_and_decode (params, 0, '\0\0&=');
  pars := vector ();
  for (declare i int, i := 0; i < length (arr); i := i + 2)
     {
       declare tmp any;
       tmp := split_and_decode (arr[i+1]);
       tmp := tmp[0];
       pars := vector_concat (pars, vector (arr[i]||'='||tmp));
     }
  pars := __vector_sort (pars);
  str := '';
  foreach (any elm in pars) do
    {
      str := str || elm;
    }
  str := str || secret;
  return md5 (str);
};

create procedure  DB.DBA.MQL_TREE_TO_XML_REC (in tree any, in tag varchar, inout ses any)
{
  if (not isarray (tree) or isstring (tree))
    http_value (tree, tag, ses);
  else if (length (tree) > 1 and __tag (tree[0]) = 255)
    {
      http (sprintf ('<%U>', tag), ses);
      for (declare i,l int, i := 2, l := length (tree); i < l; i := i + 2)
         {
	   DB.DBA.MQL_TREE_TO_XML_REC (tree[i+1], tree[i], ses);
	 }
      http (sprintf ('</%U>', tag), ses);
    }
  else if (length (tree) > 0)
    {
      for (declare i,l int, i := 0, l := length (tree); i < l; i := i + 1)
         {
	   DB.DBA.MQL_TREE_TO_XML_REC (tree[i], tag, ses);
	 }
    }
}
;

create procedure  DB.DBA.MQL_TREE_TO_XML (in tree any)
{
  declare ses any;
  ses := string_output ();
  DB.DBA.MQL_TREE_TO_XML_REC (tree, 'results', ses);
  ses := string_output_string (ses);
  ses := xtree_doc (ses);
  return ses;
}
;

create procedure DB.DBA.RDF_LOAD_MQL (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,
    inout _ret_body any, inout aq any, inout ps any, inout _key any, inout opts any)
{
  declare qr, path, hdr any;
  declare tree, xt, xd, types any;
  declare k, cnt, url varchar;

  hdr := null;
  declare exit handler for sqlstate '*'
    {
      --dbg_printf ('%s', __SQL_MESSAGE);
      return 0;
    };

  path := split_and_decode (new_origin_uri, 0, '%\0/');
  --dbg_obj_print (path);
  if (length (path) < 1)
    return 0;
  k := path [length(path) - 1];

  if (k like '#%')
    k := sprintf ('"id":"%s"', k);
  else
    k := sprintf ('"key":"%s"', k);

  qr := sprintf ('{"ROOT":{"query":[{%s, "type":[]}]}}', k);
  url := sprintf ('http://www.freebase.com/api/service/mqlread?queries=%U', qr);
  --dbg_obj_print (url);
  cnt := http_get (url, hdr);
  tree := json_parse (cnt);
  xt := get_keyword ('ROOT', tree);
  if (not isarray (xt))
    return 0;
  xt := get_keyword ('result', xt);
  types := vector ();
  foreach (any tp in xt) do
    {
      declare tmp any;
      --dbg_obj_print (tp);
      tmp := get_keyword ('type', tp);
      types := vector_concat (types, tmp);
    }
  --types := get_keyword ('type', xt);
  foreach (any tp in types) do
    {
      qr := sprintf ('{"ROOT":{"query":{%s, "type":"%s", "*":[]}}}', k, tp);
      url := sprintf ('http://www.freebase.com/api/service/mqlread?queries=%U', qr);
      cnt := http_get (url, hdr);
      --dbg_printf ('%s', cnt);
      tree := json_parse (cnt);
      xt := get_keyword ('ROOT', tree);
      xt := DB.DBA.MQL_TREE_TO_XML (tree);
      xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/mql2rdf.xsl', xt, vector ('baseUri', coalesce (dest, graph_iri)));
      xd := serialize_to_UTF8_xml (xt);
      --dbg_printf ('%s', xd);
      DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
    }
  return 1;
}
;

create procedure FQL_CALL (in q varchar, in api_key varchar, in ses_id varchar, in secret varchar)
{
  declare url, pars, sig, ret varchar;
  url := 'http://api.facebook.com/restserver.php?';
  pars := 'method=facebook.fql.query&api_key='||api_key||'&v=1.0&session_key='||ses_id||'&call_id='|| cast (msec_time () as varchar) ||
   '&query=' || sprintf ('%U', q) ;
  sig := DB.DBA.FB_SIG (pars, secret);
  url := url || pars || '&sig=' || sig;
  --dbg_printf ('%s', url);
  ret := http_get (url);
  return ret;
}
;

create procedure DB.DBA.RDF_LOAD_FQL (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,
    inout _ret_body any, inout aq any, inout ps any, inout _key any, inout opts any)
{
  declare api_key, ses_id, secret varchar;
  declare ret, tmp, karr, xt, xd any;
  declare url, sig, pars, q, own, pid, aid, acc varchar;

  --dbg_obj_print (graph_iri, new_origin_uri);
  declare exit handler for sqlstate '*'
    {
      --dbg_printf ('%s', __SQL_MESSAGE);
      return 0;
    };

  if (isarray (opts) = 0 or mod (length(opts), 2) <> 0)
    {
--      dbg_obj_print (_key, opts);
      return 0;
    }

  acc := get_keyword ('get:login', opts);
  api_key := null;
  if (acc is not null)
    {
      tmp := null;
      if (__proc_exists ('DB.DBA.WA_USER_GET_SVC_KEY') is not null)
	tmp := DB.DBA.WA_USER_GET_SVC_KEY (acc, 'FBKey');
      if (tmp is null)
	tmp := DB.DBA.USER_GET_OPTION (acc, 'FBKey');
      if (tmp is not null)
	{
	  tmp := replace (tmp, '\r', '\n');
	  tmp := replace (tmp, '\n\n', '\n');
	  tmp := rtrim (tmp, '\n');
	  tmp := split_and_decode (tmp, 0, '\0\0\n=');
	  api_key := get_keyword ('key', tmp);
	  secret := get_keyword ('secret', tmp);
	  ses_id := get_keyword ('session', tmp);
	}
    }
  if (0 = length (api_key))
    {
      api_key := _key;
      secret := get_keyword ('secret', opts);
      ses_id := get_keyword ('session', opts);
    }
  if (not length (api_key) or not length (secret) or not length (ses_id))
    return 0;

  own := ''; pid := '';
  if (acc is null)
    acc := '';

  tmp := sprintf_inverse (graph_iri, 'http://www.facebook.com/album.php?aid=%s&l=%s&id=%s', 0);
  if (length (tmp) = 3)
    {
  own := tmp[2];
  aid := tmp[0];
    }
  else
    {
      tmp := sprintf_inverse (graph_iri, 'http://www.facebook.com/album.php?aid=%s&id=%s', 0);
      if (length (tmp) <> 2)
	goto try_profile;
      own := tmp[1];
      aid := tmp[0];
    }

  q := sprintf ('SELECT pid, aid, owner, src_small, src_big, src, link, caption, created FROM photo '||
  'WHERE aid in (select aid from album where owner = %s and strpos (link, "aid=%s&") > 0)', own, aid);
  ret := DB.DBA.FQL_CALL (q, api_key, ses_id, secret);
  xt := xtree_doc (ret);
  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/fql2rdf.xsl', xt, vector ('baseUri', coalesce (dest, graph_iri), 'login', acc));
  xd := serialize_to_UTF8_xml (xt);
--  dbg_printf ('%s', xd);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));

  q := sprintf ('SELECT aid, cover_pid, owner, name, created, modified, description, location, size, link FROM album '||
  'WHERE owner = %s and strpos (link, "aid=%s&") > 0', own, aid);
  ret := DB.DBA.FQL_CALL (q, api_key, ses_id, secret);
  xt := xtree_doc (ret);
  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/fql2rdf.xsl', xt, vector ('baseUri', coalesce (dest, graph_iri), 'login', acc));
  xd := serialize_to_UTF8_xml (xt);
--  dbg_printf ('%s', xd);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
  goto end_sp;

try_profile:
  tmp := sprintf_inverse (graph_iri, 'http://www.facebook.com/%s/%s/%s', 0);
  if (length (tmp) <> 3)
    {
      tmp := sprintf_inverse (graph_iri, 'http://www.facebook.com/profile.php?id=%s', 0);
      if (length (tmp) <> 1)
    return 0;
      own := tmp[0];
    }
  else
    own := tmp[2];
  q :=  sprintf ('SELECT uid, first_name, last_name, name, pic_small, pic_big, pic_square, pic, affiliations, profile_update_time, timezone, religion, birthday, sex, hometown_location, meeting_sex, meeting_for, relationship_status, significant_other_id, political, current_location, activities, interests, is_app_user, music, tv, movies, books, quotes, about_me, hs_info, education_history, work_history, notes_count, wall_count, status, has_added_app FROM user WHERE uid = %s', own);
  ret := DB.DBA.FQL_CALL (q, api_key, ses_id, secret);
  --dbg_printf ('%s', ret);
  xt := xtree_doc (ret);
  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/fql2rdf.xsl', xt, vector ('baseUri', coalesce (dest, graph_iri), 'login', acc));
  xd := serialize_to_UTF8_xml (xt);
--  dbg_printf ('%s', xd);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));

  q := sprintf ('SELECT aid, cover_pid, owner, name, created, modified, description, location, size, link FROM album '||
  'WHERE owner = %s', own);
  ret := DB.DBA.FQL_CALL (q, api_key, ses_id, secret);
  xt := xtree_doc (ret);
  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/fql2rdf.xsl', xt, vector ('baseUri', coalesce (dest, graph_iri), 'login', acc));
  xd := serialize_to_UTF8_xml (xt);
--  dbg_printf ('%s', xd);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));

  q := sprintf ('select eid, name, tagline, nid, pic_small, pic_big, pic, host, description, event_type, event_subtype, '||
  ' start_time, end_time, creator, update_time, location, venue from event where eid in '||
  '(SELECT eid FROM event_member where uid = %s)', own);
  ret := DB.DBA.FQL_CALL (q, api_key, ses_id, secret);
  xt := xtree_doc (ret);
  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/fql2rdf.xsl', xt, vector ('baseUri', coalesce (dest, graph_iri), 'login', acc));
  xd := serialize_to_UTF8_xml (xt);
--  dbg_printf ('%s', xd);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));

--  q := sprintf ('select uid2 from friend where uid1 = %s', own);
--  ret := DB.DBA.FQL_CALL (q, api_key, ses_id, secret);
--  dbg_printf ('%s', ret);
--  xt := xtree_doc (ret);
--  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/fql2rdf.xsl', xt, vector ('baseUri', coalesce (dest, graph_iri)));
--  xd := serialize_to_UTF8_xml (xt);
--  dbg_printf ('%s', xd);
--  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));

  q := sprintf ('SELECT uid, first_name, last_name, name, pic_small, pic_big, pic_square, pic, profile_update_time, timezone, religion, birthday, sex, current_location FROM user WHERE uid IN (select uid2 from friend where uid1 = %s)', own);
  ret := DB.DBA.FQL_CALL (q, api_key, ses_id, secret);
  --dbg_printf ('%s', ret);
  xt := xtree_doc (ret);
  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/fql2rdf.xsl', xt, vector ('baseUri', coalesce (dest, graph_iri), 'login', acc));
  xd := serialize_to_UTF8_xml (xt);
  --dbg_printf ('%s', xd);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
  goto end_sp;

end_sp:
  return 1;
};

create procedure DB.DBA.RDF_LOAD_BUGZILLA (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,    inout _ret_body any, inout aq any, inout ps any, inout _key any, inout opts any)
{
  declare xd, xt, url, tmp, api_key, img_id, hdr, exif any;
  declare exit handler for sqlstate '*'
    {
      return 0;
    };
  tmp := sprintf_inverse (new_origin_uri, 'http://%s/show_bug.cgi?id=%s', 0);
  img_id := tmp[1];
  if (img_id is null)
    return 0;
  url := concat(new_origin_uri, '&ctype=xml');
  tmp := http_get (url, hdr);
  if (hdr[0] not like 'HTTP/1._ 200 %')
    signal ('22023', trim(hdr[0], '\r\n'), 'RDFXX');
  xd := xtree_doc (tmp);
  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/bugzilla2rdf.xsl', xd, vector ('baseUri', coalesce (dest, graph_iri)));
  xd := serialize_to_UTF8_xml (xt);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
  return 1;
}
;

create procedure DB.DBA.RDF_LOAD_SVG (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,    inout _ret_body any, inout aq any, inout ps any, inout _key any, inout opts any)
{
  declare xd, xt, url, tmp, api_key, img_id, hdr, exif any;
  declare exit handler for sqlstate '*'
    {
      return 0;
    };
  tmp := http_get (new_origin_uri, hdr);
  --if (hdr[0] not like 'HTTP/1._ 200 %');
  --  signal ('22023', trim(hdr[0], '\r\n'), 'RDFXX');
  xd := xtree_doc (tmp);
  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/svg2rdf.xsl', xd, vector ('baseUri', coalesce (dest, graph_iri)));
  xd := serialize_to_UTF8_xml (xt);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
  return 1;
}
;

create procedure DB.DBA.RDF_LOAD_OO_DOCUMENT (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,
    inout _ret_body any, inout aq any, inout ps any, inout _key any, inout opts any)
{
  declare meta, tmp varchar;
  declare xt, xd any;

--  dbg_obj_print ('DB.DBA.RDF_LOAD_OO_DOCUMENT');
  if (__proc_exists ('UNZIP_UnzipFileFromArchive', 2) is null)
    return 0;
  tmp := tmp_file_name ('rdfm', 'odt');
  string_to_file (tmp, _ret_body, -2);
  meta := UNZIP_UnzipFileFromArchive (tmp, 'meta.xml');
  file_delete (tmp, 1);
  if (meta is null)
    return 0;
  xt := xtree_doc (meta);
  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/oo2rdf.xsl', xt, vector ('baseUri', coalesce (dest, graph_iri)));
  xd := serialize_to_UTF8_xml (xt);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
  return 1;
}
;

create procedure DB.DBA.RDF_LOAD_YAHOO_TRAFFIC_DATA (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,
    inout _ret_body any, inout aq any, inout ps any, inout _key any, inout opts any)
{
  declare meta, tmp varchar;
  declare xt, xd any;

  declare exit handler for sqlstate '*'
    {
      return 0;
    };
--  dbg_obj_print ('DB.DBA.RDF_LOAD_YAHOO_TRAFFIC_DATA');
  xt := xtree_doc (_ret_body);
  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/yahoo_trf2rdf.xsl', xt, vector ('baseUri', coalesce (dest, graph_iri)));
  xd := serialize_to_UTF8_xml (xt);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
  return 1;
}
;

create procedure DB.DBA.RDF_LOAD_ICAL (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,
    inout _ret_body any, inout aq any, inout ps any, inout _key any, inout opts any)
{
  declare meta, tmp varchar;
  declare xt, xd any;

  declare exit handler for sqlstate '*'
    {
      return 0;
    };
--  dbg_obj_print ('ICAL');
  xt := xml_tree_doc (DB.DBA.IMC_TO_XML (_ret_body));
  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/ics2rdf.xsl', xt, vector ('baseUri', coalesce (dest, graph_iri)));
  xd := serialize_to_UTF8_xml (xt);
--  string_to_file ('x.rdf', xd, -2);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
  return 1;
}
;

create procedure DB.DBA.RDF_LOAD_AMAZON_ARTICLE (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,
    inout _ret_body any, inout aq any, inout ps any, inout _key any, inout opts any)
{
  declare xd, xt, url, tmp, api_key, asin, hdr, exif any;
  asin := null;
  declare exit handler for sqlstate '*'
    {
      return 0;
    };

  if (new_origin_uri like 'http://%amazon.%/gp/product/%')
    {
      tmp := sprintf_inverse (new_origin_uri, 'http://%samazon.%s/gp/product/%s', 0);
      asin := rtrim (tmp[2], '/');
    }
  else if (new_origin_uri like 'http://%amazon.%/o/ASIN/%')
    {
      tmp := sprintf_inverse (new_origin_uri, 'http://%samazon.%s/o/ASIN/%s', 0);
      asin := rtrim (tmp[2], '/');
    }
  else if (new_origin_uri like 'http://%amazon.%/%/dp/%/%')
    {
      tmp := sprintf_inverse (new_origin_uri, 'http://%samazon.%s/%s/dp/%s/%s', 0);
      asin := tmp[3];
    }
  else if (new_origin_uri like 'http://%amazon.%/exec/obidos/ASIN/%')
    {
      tmp := sprintf_inverse (new_origin_uri, 'http://%samazon.%s/exec/obidos/ASIN/%s', 0);
      asin := rtrim (tmp[2], '/');
    }
  else if (new_origin_uri like 'http://%amazon.%/exec/obidos/tg/detail/-/%/%')
    {
      tmp := sprintf_inverse (new_origin_uri, 'http://%samazon.%s/exec/obidos/tg/detail/-/%s/%s', 0);
      asin := tmp[2];
    }
  else
    return 0;

  api_key := _key;
  if (asin is null or not isstring (api_key))
    return 0;

  url := sprintf ('http://xml.amazon.com/onca/xml3?t=webservices-20&dev-t=%s&AsinSearch=%s&type=lite&f=xml',
          api_key, asin);

--  tmp := xml_tree_doc (
--  	AmazonSearchService.AsinSearchRequest (
--	  soap_box_structure ('asin', asin, 'tag', 'webservices-20', 'type', 'lite', 'devtag', api_key)));
  tmp := http_get (url, hdr);
  if (hdr[0] not like 'HTTP/1._ 200 %')
    signal ('22023', trim(hdr[0], '\r\n'), 'RDFXX');
--  dbg_printf ('%s', tmp);
  xd := xtree_doc (tmp);
  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/amazon2rdf.xsl', xd, vector ('baseUri', coalesce (dest, graph_iri)));
  xd := serialize_to_UTF8_xml (xt);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
  return 1;
}
;


create procedure DB.DBA.RDF_LOAD_FLICKR_IMG (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,
    inout _ret_body any, inout aq any, inout ps any, inout _key any, inout opts any)
{
  declare xd, xt, url, tmp, api_key, img_id, hdr, exif any;
  declare exit handler for sqlstate '*'
    {
      return 0;
    };
  tmp := sprintf_inverse (new_origin_uri, 'http://farm%s.static.flickr.com/%s/%s_%s.%s', 0);
  img_id := tmp[2];
  api_key := _key; --cfg_item_value (virtuoso_ini_path (), 'SPARQL', 'FlickrAPIkey');
  if (tmp is null or length (tmp) <> 5 or not isstring (api_key))
    return 0;
  url := sprintf ('http://api.flickr.com/services/rest/?method=flickr.photos.getInfo&photo_id=%s&api_key=%s',
    img_id, api_key);
  tmp := http_get (url, hdr);
  if (hdr[0] not like 'HTTP/1._ 200 %')
    signal ('22023', trim(hdr[0], '\r\n'), 'RDFXX');
  xd := xtree_doc (tmp);
  exif := xtree_doc ('<rsp/>');

  {
      declare exit handler for sqlstate '*' { goto ende; };
      url := sprintf ('http://api.flickr.com/services/rest/?method=flickr.photos.getExif&photo_id=%s&api_key=%s',
	img_id, api_key);
      tmp := http_get (url, hdr);
      if (hdr[0] like 'HTTP/1._ 200 %')
	exif := xtree_doc (tmp);
      ende:;
  }

  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/flickr2rdf.xsl', xd, vector ('baseUri', coalesce (dest, graph_iri), 'exif', exif));
  xd := serialize_to_UTF8_xml (xt);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
  return 1;
}
;

create procedure DB.DBA.RDF_LOAD_EBAY_ARTICLE (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,
    inout _ret_body any, inout aq any, inout ps any, inout ser_key any, inout opts any)
{
  declare xd, xt, url, tmp, api_key, item_id, hdr, karr, use_sandbox, user_id any;
  declare exit handler for sqlstate '*'
    {
      return 0;
    };

  use_sandbox := 0;
  karr := deserialize (ser_key);
  if (not isarray (karr) or length (karr) <> 2)
    return 0;

  if (new_origin_uri like 'http://cgi.sandbox.ebay.com/%&item=%&%')
    {
      tmp := sprintf_inverse (new_origin_uri, 'http://cgi.sandbox.ebay.com/%s&item=%s&%s', 0);
      use_sandbox := 1;
    }
  else if (new_origin_uri like 'http://cgi.ebay.com/%QQitemZ%QQ%')
    tmp := sprintf_inverse (new_origin_uri, 'http://cgi.ebay.com/%sQQitemZ%sQQ%s', 0);
  else
    return 0;

  api_key := karr[0];
  user_id := karr[1];
  if (tmp is null or length (tmp) <> 3 or not isstring (api_key) or not isstring (user_id))
    return 0;

  item_id := tmp[1];

  url := sprintf ('http://rest.api%s.ebay.com/restapi?CallName=GetItem&RequestToken=%s&RequestUserId=%s&ItemID=%s&Version=491',
          case when use_sandbox = 1 then '.sandbox' else '' end,
	  api_key, user_id, item_id);

--  dbg_obj_print (url);

  tmp := http_get (url, hdr);
  if (hdr[0] not like 'HTTP/1._ 200 %')
    signal ('22023', trim(hdr[0], '\r\n'), 'RDFXX');

  xd := xtree_doc (tmp);
  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/ebay2rdf.xsl', xd, vector ('baseUri', coalesce (dest, graph_iri)));

  xd := serialize_to_UTF8_xml (xt);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
  return 1;
}
;

create procedure DB.DBA.RDF_LOAD_DAV_META (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,
    inout _ret_body any, inout aq any, inout ps any, inout ser_key any, inout opts any)
{
  declare xd, groupdest any;

  groupdest := get_keyword_ucase ('get:group-destination', opts);
  xd := DAV_EXTRACT_META_AS_RDF_XML (new_origin_uri, _ret_body);
  if (xd is not null)
    {
      DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
      if (groupdest is not null)
        DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, groupdest);
      return 1;
    }
  return 0;
}
;

create procedure RDF_MAPPER_CACHE_CHECK (in url varchar, in top_url varchar, out old_etag varchar, out old_last_modified any)
{
  declare old_exp_is_true, old_expiration, old_read_count any;
  whenever not found goto no_record;
  select HS_EXP_IS_TRUE, HS_EXPIRATION, HS_LAST_MODIFIED, HS_LAST_ETAG, HS_READ_COUNT
      into old_exp_is_true, old_expiration, old_last_modified, old_etag, old_read_count
      from DB.DBA.SYS_HTTP_SPONGE where HS_FROM_IRI = url and HS_PARSER = 'DB.DBA.RDF_LOAD_HTTP_RESPONSE';
  -- as we are at point we load everything we always do re-load
no_record:
  return 0;
}
;

create procedure
RDF_MAPPER_CACHE_REGISTER (in url varchar, in top_url varchar, inout hdr any,
    			   in old_last_modified any, in download_size int, in load_msec int)
{
  declare explicit_refresh, new_expiration, ret_content_type, ret_etag, ret_date, ret_expires, ret_last_modif,
	  ret_dt_date, ret_dt_expires, ret_dt_last_modified any;

  if (not isarray (hdr))
    return;

  url := WS.WS.EXPAND_URL (top_url, url);
  explicit_refresh := null;
  new_expiration := now ();
  DB.DBA.SYS_HTTP_SPONGE_GET_CACHE_PARAMS (explicit_refresh, old_last_modified,
      hdr, new_expiration, ret_content_type, ret_etag, ret_date, ret_expires, ret_last_modif,
       ret_dt_date, ret_dt_expires, ret_dt_last_modified);

--  dbg_obj_print ('url=', url);
--  dbg_obj_print ('old_last_modified=',old_last_modified);
--  dbg_obj_print ('new_expiration=',new_expiration);
--  dbg_obj_print ('ret_content_type=',ret_content_type);
--  dbg_obj_print ('ret_etag=',ret_etag);
--  dbg_obj_print ('ret_date=',ret_date);
--  dbg_obj_print ('ret_expires=',ret_expires);
--  dbg_obj_print ('ret_last_modif=',ret_last_modif);
--  dbg_obj_print ('ret_dt_date=',ret_dt_date);
--  dbg_obj_print ('ret_dt_expires=',ret_dt_expires);
--  dbg_obj_print ('ret_dt_last_modified=',ret_dt_last_modified);

  insert replacing DB.DBA.SYS_HTTP_SPONGE (
      HS_LAST_LOAD,
      HS_LAST_ETAG,
      HS_LAST_READ,
      HS_EXP_IS_TRUE,
      HS_EXPIRATION,
      HS_LAST_MODIFIED,
      HS_DOWNLOAD_SIZE,
      HS_DOWNLOAD_MSEC_TIME,
      HS_READ_COUNT,
      HS_SQL_STATE,
      HS_SQL_MESSAGE,
      HS_LOCAL_IRI,
      HS_PARSER,
      HS_ORIGIN_URI,
      HS_ORIGIN_LOGIN,
      HS_FROM_IRI)
      values
      (
       now (),
       ret_etag,
       now(),
       case (isnull (ret_dt_expires)) when 1 then 0 else 1 end,
       coalesce (ret_dt_expires, new_expiration, now()),
       ret_dt_last_modified,
       download_size,
       load_msec,
       1,
       NULL,
       NULL,
       url,
       'DB.DBA.RDF_LOAD_HTTP_RESPONSE',
       url,
       NULL,
       top_url
       );

  return;
}
;

create procedure DB.DBA.RDF_LOAD_OPENSOCIAL_PERSON (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,
    inout _ret_body any, inout aq any, inout ps any, inout _key any, inout opts any)
{
  declare xt, xd, tmp, cnt, hdr any;
  declare mail, pwd, auth, auth_header varchar;

  mail := get_keyword ('email', opts, null);
  pwd := get_keyword ('password', opts, null);
  --dbg_obj_print ('DB.DBA.RDF_LOAD_OPENSOCIAL_PERSON');
  declare exit handler for sqlstate '*'
    {
--      dbg_obj_print (__SQL_MESSAGE);
      return 0;
    };
  auth_header := null;
  if (length (mail) + length (pwd))
    {
      cnt := http_client (url=>'https://www.google.com/accounts/ClientLogin',
	    http_method=>'POST', body=>sprintf ('Email=%U&Passwd=%U&source=OpenLink-Sponger-1&service=ot', mail, pwd));
      if (cnt like 'Error=%')
	return 0;
      cnt := replace (cnt, '\r', '\n');
      cnt := replace (cnt, '\n\n', '\n');
      tmp := split_and_decode (cnt, 0, '\0\0\n=');
      auth := get_keyword ('Auth', tmp);
      if (auth is not null)
	auth_header := 'Authorization: GoogleLogin auth='||auth;
    }
  cnt := RDF_HTTP_URL_GET (new_origin_uri, new_origin_uri, hdr, 'GET', auth_header);
  --dbg_obj_print (cnt);
  if (hdr[0] not like  'HTTP/1._ 200 %')
    return 0;
  xd := xtree_doc (cnt);
  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/ospeople2rdf.xsl', xd,
  	vector ('baseUri', coalesce (dest, graph_iri)));
  xd := serialize_to_UTF8_xml (xt);
--  dbg_printf ('%s', xd);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
  return 1;
}
;

create procedure DB.DBA.RDF_LOAD_WIKIPEDIA_ARTICLE
	(in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,
    	 inout _ret_body any, inout aq any, inout ps any, inout _key any, inout opts any)
{

    declare get_uri, body any;

    get_uri := split_and_decode (new_origin_uri, 0, '\0\0/');
    get_uri := get_uri[length (get_uri) - 1];

    body := http_get ('http://dbpedia.org/data/'|| get_uri, null, 'GET', 'Accept: application/xml, */*');

    return DB.DBA.RDF_LOAD_RDFXML (body, new_origin_uri, coalesce (dest, graph_iri));
}
;


create procedure DB.DBA.RDF_DO_XSLT_AND_LOAD (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,
    in xt any, inout mdta any, in xslt_sheet varchar, in what varchar, in base varchar)
{
  declare xslt_uri varchar;
  declare xslt_body, xd, media, ret, xsl_doc any;
  xsl_doc := null;
  ret := null;
  declare exit handler for sqlstate '*' { goto try_next; };
  xslt_uri := WS.WS.EXPAND_URL (base, cast (xslt_sheet as varchar));
  {
    declare exit handler for sqlstate '*'
    {
      --dbg_obj_print (__SQL_MESSAGE, xslt_uri);
      if (registry_get ('__sparql_sponge_use_w3c_xslt') = 'on')
	goto try_w3c;
      else
	goto try_next;
    };
    --dbg_obj_print (xslt_uri, new_origin_uri);
    xslt_stale (xslt_uri);
    {
      -- /* we try to get xslt with content negotiation */
      declare exit handler for sqlstate '*' {
	--dbg_obj_print (__SQL_MESSAGE, xslt_uri);
	goto try_next;
      };
      xslt_body := http_get (xslt_uri, null, 'GET', 'Accept: application/xml, */*');
      if (length (xslt_body))
	{
	  declare exit handler for sqlstate '*' {
	     --dbg_obj_print (__SQL_MESSAGE, xslt_uri);
	     if (registry_get ('__sparql_sponge_use_w3c_xslt') = 'on')
	       goto try_w3c;
	     else
	       goto try_next;
	  };
	  xslt_sheet (xslt_uri, xtree_doc (xslt_body, 0, xslt_uri));
	}
    }
    xd := DB.DBA.RDF_MAPPER_XSLT (xslt_uri, xt);
    xsl_doc := xd;
    if (what <> '')
      goto try_next;
    if (xpath_eval ('count(/RDF/*)', xd) > 0)
      {
	mdta := mdta + 1;
      }
    media := xml_tree_doc_media_type (xd);
    xd := serialize_to_UTF8_xml (xd);

    --dbg_printf ('----------------------------------\n%s\n----------------------------------\n',xd);

    if (media = 'text/rdf+n3')
      {
	DB.DBA.TTLP (xd, base, coalesce (dest, graph_iri));
	mdta := mdta + 1;
      }
    else
      DB.DBA.RDF_LOAD_RDFXML (xd, base, coalesce (dest, graph_iri));
    --dbg_obj_print ('loaded', xd);
    goto try_next;
  }
  try_w3c:
  if (0)
    log_message (sprintf ('Using w3c xslt=[%s]', xslt_uri));
  xd := http_get (sprintf ('http://www.w3.org/2000/06/webdata/xslt?xslfile=%U;xmlfile=%U', xslt_uri, new_origin_uri));
  xsl_doc := xtree_doc (xd);
  if (what <> '')
    goto try_next;
  if (xpath_eval ('count(/RDF/*)', xsl_doc) > 0)
    {
      mdta := mdta + 1;
    }
  xslt_done:
  --dbg_printf ('----------------------------------\n%s\n----------------------------------\n',xd);
  DB.DBA.RDF_LOAD_RDFXML (xd, base, coalesce (dest, graph_iri));
  try_next:;
  if (isentity (xsl_doc))
    {
      if (what = 'ns')
        {
	  ret  := xpath_eval ('[ xmlns:dv="http://www.w3.org/2003/g/data-view#" '||
	    ' xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" ] '||
	    '//dv:namespaceTransformation/@rdf:resource', xsl_doc, 0);
        }
      else if (what = 'pf')
        {
          ret := xpath_eval ('[ xmlns:dv="http://www.w3.org/2003/g/data-view#" '||
	    ' xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" ] '||
	    '//dv:profileTransformation/@rdf:resource', xsl_doc, 0);
        }
    }
  return ret;
};

create procedure DB.DBA.RDF_MAPPER_EXPN_URLS (in all_xslt any, in base varchar)
{
  declare ret any;
  ret := vector ();
  foreach (any _xslt in all_xslt) do
    {
      declare split any;
      split := split_and_decode (cast (_xslt as varchar),0, '\0\0 ');
      foreach (any xslt in split) do
        {
	  if (length (xslt))
	    {
	      xslt := WS.WS.EXPAND_URL (base, xslt);
	      ret := vector_concat (ret, vector (xslt));
	    }
	}
    }
  return ret;
};

create procedure DB.DBA.RDF_LOAD_GRDDL_REC (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,
    in xt any, inout mdta any, inout visited any, in what varchar)
{
  declare pf_docs, ns_doc, barr any;
  declare profile varchar;
  declare profs, hdr, ret_arr any;
  declare base_url, ns_url varchar;
  declare tf1, tf2, tf3, all_xslt, ns_trf, profile_trf  any;

  ret_arr := null;
  pf_docs := null;
  ns_doc := tf1 := tf2 := tf3 := null;
  profile_trf := ns_trf := null;

  --dbg_obj_print ('looking in:', new_origin_uri, ' for=', what);

  -- take base & PF & NS URL
  base_url := cast (xpath_eval ('/html/head/base/@href', xt) as varchar);
  if (length (base_url) = 0)
    {
      base_url := cast (xpath_eval ('/*[1]/@xml:base', xt) as varchar);
    }

  if (length (base_url) = 0)
     base_url := new_origin_uri;

  barr := WS.WS.PARSE_URI (base_url);
  -- if base is relative
  if (barr [0] = '')
    base_url := WS.WS.EXPAND_URL (new_origin_uri, base_url);

  profile := cast (xpath_eval ('/html/head/@profile', xt) as varchar);
  profs := null;
  if (profile is not null)
    profs := split_and_decode (profile, 0, '\0\0 ');

  ns_url := cast (xpath_eval ('namespace-uri (/*[1])', xt) as varchar);
  -- /* known NS */
  if (
      strstr (ns_url, 'http://www.w3.org/2003/g/data-view') is not null
      or ns_url = 'http://www.w3.org/1999/xhtml'
      or ns_url = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'
      or ns_url = 'http://www.w3.org/2005/Atom'
      )
    ns_url := null;

  -- take 'transform' attributes
  if (strstr (profile, 'http://www.w3.org/2003/g/data-view') is not null)
    {
      tf1 := xpath_eval ('/html/head/link[@rel="transformation"]/@href', xt, 0);
      tf2 := xpath_eval ('//a[contains(concat(" ",@rel," "), " transformation ")]/@href', xt, 0);
    }
  -- /* xml doc */
  tf3 := xpath_eval ('[ xmlns:dv="http://www.w3.org/2003/g/data-view#" ] /*[1]/@dv:transformation', xt, 0);

  -- take NS transform
  if (length (ns_url) and strstr (visited, ' ' || ns_url || ' ') is null)
    {
      declare uarr, stat, msg, dta, meta any;
      declare cnt, tmp_url, tmp_xt, tmp_prof, tmp_profs any;

      tmp_xt := null;
      visited := visited || ' ' || ns_url || ' ';
      uarr := WS.WS.PARSE_URI (ns_url);
      uarr[5] := '';
      ns_url := vspx_uri_compose (uarr);

      declare exit handler for sqlstate '*' {
         goto no_ns_doc;
      };

      hdr := null;
      tmp_xt := null;
      if (0)
	log_message (sprintf ('NS get %s', ns_url));
      cnt := RDF_HTTP_URL_GET (ns_url, base_url, hdr, 'GET', 'Accept: application/rdf+xml, application/xml, */*');
      tmp_xt := xtree_doc (cnt, 0);

      ns_doc := vector (vector (ns_url, tmp_xt));

      ns_trf := xpath_eval ('[ xmlns:dv="http://www.w3.org/2003/g/data-view#" '||
      ' xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" ] '||
      '//dv:namespaceTransformation/@rdf:resource', tmp_xt, 0);
      ns_trf := DB.DBA.RDF_MAPPER_EXPN_URLS (ns_trf, ns_url);
      no_ns_doc:;
    }

  -- take PF transform
  foreach (any prof in profs) do
    {
      declare prof_base any;
      if (length (prof) = 0)
        goto next_prof_1;
      prof_base := null;
      prof := WS.WS.EXPAND_URL (base_url, prof);
      declare cnt, tmp_url, tmp_xt, tmp_prof, tmp_profs any;
      declare exit handler for sqlstate '*' {
	goto next_prof_1;
      };
      hdr := null;
      tmp_xt := null;
      if (strstr (prof, 'http://www.w3.org/2003/g/data-view') is not null)
        goto next_prof_1;
      if (0)
        log_message (sprintf ('PF get %s', prof));
      cnt := RDF_HTTP_URL_GET (prof, base_url, hdr, 'GET', 'Accept: */*');
      tmp_xt := xtree_doc (cnt, 0);

      pf_docs := vector_concat (pf_docs, vector (vector (prof, tmp_xt)));

      prof_base := cast (xpath_eval ('/html/head/base/@href', tmp_xt) as varchar);
      if (length (prof_base) = 0)
        {
	  prof_base := cast (xpath_eval ('/*[1]/@xml:base', tmp_xt) as varchar);
	}
      if (length (prof_base) = 0)
        prof_base := prof;

      tmp_prof := xpath_eval (
      '//*[contains (concat (" ", @rel, " "), " profileTransformation ")]/@href', tmp_xt, 0);
      --  get here profileTransformation and push into a profile_trf
      tmp_prof := DB.DBA.RDF_MAPPER_EXPN_URLS (tmp_prof, prof_base);
      profile_trf := vector_concat (profile_trf, tmp_prof);

      tmp_prof := xpath_eval ('[ xmlns:dv="http://www.w3.org/2003/g/data-view#" '||
	' xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" ] '||
	'//dv:profileTransformation/@rdf:resource', tmp_xt, 0);
      tmp_prof := DB.DBA.RDF_MAPPER_EXPN_URLS (tmp_prof, prof_base);
      profile_trf := vector_concat (profile_trf, tmp_prof);
      next_prof_1:;
    }

  all_xslt := vector_concat (tf1, tf2, tf3, profile_trf, ns_trf);

  -- if no xslt, traverse the NF & PF docs above
  if (length (all_xslt) = 0)
    {
      declare ret any;
      foreach (any pf_item in pf_docs) do
        {
	  ret := DB.DBA.RDF_LOAD_GRDDL_REC (graph_iri, pf_item[0], dest, pf_item[1], mdta, visited, 'pf');
	  --dbg_obj_print ('ret1=', ret);
	  all_xslt := vector_concat (all_xslt, ret);
	}
      foreach (any ns_item in ns_doc) do
        {
	  ret := DB.DBA.RDF_LOAD_GRDDL_REC (graph_iri, ns_item[0], dest, ns_item[1], mdta, visited, 'ns');
	  --dbg_obj_print ('ret2=', ret);
	  all_xslt := vector_concat (all_xslt, ret);
	}
    }

  --dbg_obj_print ('new_origin_uri=', new_origin_uri, ' all_xslt=', all_xslt);
  -- if any apply xslt
  foreach (any _xslt in all_xslt) do
    {
      declare ret, split any;
      split := split_and_decode (cast (_xslt as varchar),0, '\0\0 ');
      foreach (any xslt in split) do
        {
	  if (0)
	   log_message (sprintf ('TRANSFORM=[%s] XSLT=[%s]', new_origin_uri, xslt));
	  ret := DB.DBA.RDF_DO_XSLT_AND_LOAD (graph_iri, new_origin_uri, dest, xt, mdta, xslt, what, base_url);
	  --dbg_obj_print ('new_origin_uri=', new_origin_uri, ' ret3=', ret);
	  ret_arr := vector_concat (ret_arr, ret);
        }
    }
  return ret_arr;
};

--
-- GRDDL filters, if signature changed web robot needs to be updated too
--
create procedure DB.DBA.RDF_LOAD_HTML_RESPONSE (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,
    inout ret_body any, inout aq any, inout ps any, inout _key any, inout opts any)
{
  -- check to microformats
  declare xt_sav, xt, xd, profile, mdta, xslt_style, profs, profs_done, feed_url, xt_xml any;
  declare xmlnss, i, l, nss, rdf_url_arr, content, hdr, rdf_in_html, old_etag, old_last_modified any;
  declare ret_flag, is_grddl, download_size, load_msec int;
  declare get_feeds, add_html_meta, grddl_loop int;
  declare base_url, ns_url, reg varchar;
  declare profile_trf, ns_trf, ext_profs any;

  get_feeds := add_html_meta := 0;
  if (isarray (opts) and 0 = mod (length(opts), 2))
    {
      if (get_keyword ('get-feeds', opts) = 'yes')
        get_feeds := 1;
      if (get_keyword ('add-html-meta', opts) = 'yes')
        add_html_meta := 1;
    }

  set_user_id ('dba');
  mdta := 0;
  ret_flag := 1;
  hdr := null;
  xt_xml := null;
  profile_trf := vector ();
  ns_trf := vector ();
  ext_profs := vector ();
  grddl_loop := 0;

  declare exit handler for sqlstate '*'
    {
      goto no_microformats;
    };

  xt_sav := xt := xtree_doc (ret_body, 2);

  {
    declare exit handler for sqlstate '*' { xt_xml := null; goto no_xml_cont; };
    xt_xml := xtree_doc (ret_body);
    no_xml_cont:;
  }

  -- this maybe is not need to be here, as it's a kind of content negotiation
  rdf_url_arr  := xpath_eval ('//head/link[ @rel="meta" and @type="application/rdf+xml" ]/@href', xt, 0);
  if (length (rdf_url_arr))
    {
      declare rdf_url_inx int;
      rdf_url_inx := 0;
      foreach (any rdf_url in rdf_url_arr) do
	{
	  declare exit handler for sqlstate '*' { goto try_next_link; };
	  rdf_url := cast (rdf_url as varchar);
	  if (RDF_MAPPER_CACHE_CHECK (rdf_url, new_origin_uri, old_etag, old_last_modified))
	    goto try_next_link;
	  load_msec := msec_time ();
	  hdr := null;
	  content := RDF_HTTP_URL_GET (rdf_url, new_origin_uri, hdr, 'GET', 'Accept: */*');
	  load_msec := msec_time () - load_msec;
	  download_size := length (content);
	  DB.DBA.RDF_LOAD_RDFXML (content, new_origin_uri, coalesce (dest, graph_iri));
	  RDF_MAPPER_CACHE_REGISTER (rdf_url, new_origin_uri, hdr, old_last_modified, download_size, load_msec);
	  rdf_url_inx := rdf_url_inx + 1;
	  ret_flag := -1;
	  try_next_link:;
	}
    }

  -- sometimes RDF is inside the xhtml
  if (xpath_eval ('/html//rdf', xt) is not null and xt_xml is not null)
    {
      declare exit handler for sqlstate '*' { goto try_grddl; };
      rdf_in_html := xpath_eval ('/html//RDF', xt_xml, 0);
      foreach (any x in rdf_in_html) do
	{
	    xd := serialize_to_UTF8_xml (x);
	    DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
	}
    }

try_grddl:
  xmlnss := xmlnss_get (xt);
  nss := '<namespaces>';
  for (i := 0, l := length (xmlnss); i < l; i := i + 2)
    {
      nss := nss || sprintf ('<namespace prefix="%s">%s</namespace>', xmlnss[i], xmlnss[i+1]);
    }
  nss := nss || '</namespaces>';
  nss := xtree_doc (nss);

  is_grddl := 0;
  if (xpath_eval ('[ xmlns:dv="http://www.w3.org/2003/g/data-view#" ] /*[1]/@dv:transformation', xt) is not null)
    {
      if (xpath_eval ('/rdf', xt) is not null and xt_xml is not null)
	{
	  declare exit handler for sqlstate '*' { goto not_rdf; };
          xd :=  DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/rdf_wo_grddl.xsl', xt_xml);
	  xd := serialize_to_UTF8_xml (xd);
	  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
	  mdta := mdta + 1;
	}
      not_rdf:;
      is_grddl := 1;
      if (xt_xml is not null)
	xt := xt_xml;
    }

  profs := null;
  profs_done := vector ();
  profile := cast (xpath_eval ('/html/head/@profile', xt) as varchar);
  if (profile is not null)
    profs := split_and_decode (profile, 0, '\0\0 ');

  reg := '';
  DB.DBA.RDF_LOAD_GRDDL_REC (graph_iri, new_origin_uri, dest, xt, mdta, reg, '');

  --dbg_obj_print ('done mdta=', mdta);

  if (mdta) -- It is recognized as GRDDL and data is loaded, stop there WAS: is_grddl and xpath_eval ('/html', xt) is null)
    goto ret;

  try_rdfa:;

  -- /* GRDDL - plan A, eRDF going here */
  foreach (any prof in profs) do
    {
      prof := WS.WS.EXPAND_URL (new_origin_uri, prof);
      xslt_style := (select GM_XSLT from DB.DBA.SYS_GRDDL_MAPPING where GM_PROFILE = prof);
      if (xslt_style is not null)
	{
	  declare exit handler for sqlstate '*' { goto next_prof; };
	  xd := DB.DBA.RDF_MAPPER_XSLT (xslt_style, xt, vector ('baseUri', coalesce (dest, graph_iri)));
	  if (xpath_eval ('count(/RDF/*)', xd) > 0)
            {
	      --dbg_obj_print ('plan A:', prof, xd);
	      mdta := mdta + 1;
	    }
	  xd := serialize_to_UTF8_xml (xd);
	  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
	  profs_done := vector_concat (profs_done, vector (prof));
	}
      next_prof:;
    }

  -- brute force attack, scan w/o profile
  if (xt_xml is not null)
    xt := xt_xml;
  --dbg_obj_print ('try all grddl mappings here');
  if (mdta = 0)
    {
      -- currently no profile in RDFa and some similar, so we try it to extract directly
      for select GM_XSLT, GM_PROFILE from DB.DBA.SYS_GRDDL_MAPPING do
	{
	  if (position (GM_PROFILE, profs_done) > 0)
	    goto try_next1;
	  declare exit handler for sqlstate '*' { goto try_next1; };
	  xd := DB.DBA.RDF_MAPPER_XSLT (GM_XSLT, xt, vector ('baseUri', coalesce (dest, graph_iri), 'nss', nss));
	  if (xpath_eval ('count(/RDF/*)', xd) > 0)
	    {
	      mdta := mdta + 1;
	      --dbg_obj_print ('plan B:', GM_XSLT, xd);
	      xd := serialize_to_UTF8_xml (xd);
	      DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
	    }
	  try_next1:;
	}
    }
    -- /* feed formats */
   if (get_feeds = 1)
    {
      -- try looking for feed
      declare rss, atom any;

      rss  := cast (xpath_eval('//head/link[ @rel="alternate" and @type="application/rss+xml" ]/@href', xt) as varchar);
      atom := cast (xpath_eval('//head/link[ @rel="alternate" and @type="application/atom+xml" ]/@href', xt) as varchar);

      declare exit handler for sqlstate '*' { goto no_feed; };

      xt := null;
      hdr := null;
      if (atom is not null)
        {
	  declare exit handler for sqlstate '*' { goto try_rss; };
	  feed_url := atom;
	  if (RDF_MAPPER_CACHE_CHECK (atom, new_origin_uri, old_etag, old_last_modified))
	    goto no_feed;
	  load_msec := msec_time ();
	  content := DB.DBA.RDF_HTTP_URL_GET (atom, new_origin_uri, hdr, 'GET', 'Accept: */*');
	  load_msec := msec_time () - load_msec;
	  download_size := length (content);
	  xt := xtree_doc (content);
	  goto do_detect;
        }
try_rss:;
      if (rss is not null)
        {
	  declare exit handler for sqlstate '*' { goto no_microformats; };
	  feed_url := rss;
	  if (RDF_MAPPER_CACHE_CHECK (rss, new_origin_uri, old_etag, old_last_modified))
	    goto no_feed;
	  load_msec := msec_time ();
	  content := DB.DBA.RDF_HTTP_URL_GET (rss, new_origin_uri, hdr, 'GET', 'Accept: */*');
	  load_msec := msec_time () - load_msec;
	  download_size := length (content);
	  xt := xtree_doc (content);
        }
do_detect:;

	-- the document itself is a feed
	if (xt is null and xpath_eval ('/rdf|/rss|/feed', xt_sav) is not null)
	  xt := xt_xml;

	if (xt is null)
	  goto no_feed;
	else if (xpath_eval ('/RDF', xt) is not null and content is not null)
	  {
	    xd := content;
	    goto ins_rdf;
	  }
	else if (xpath_eval ('/feed', xt) is not null)
	  {
	    xd := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/atom2rdf.xsl', xt);
	  }
	else if (xpath_eval ('/rss', xt) is not null)
	  {
	    xd := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/rss2rdf.xsl', xt);
	  }
	else
	  goto no_feed;

	if (xpath_eval ('count(/RDF/*)', xd) > 0)
          {
	    mdta := mdta + 1;
	  }
	xd := serialize_to_UTF8_xml (xd);
ins_rdf:
	DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
        DB.DBA.RDF_LOAD_FEED_SIOC (xd, new_origin_uri, coalesce (dest, graph_iri));
	RDF_MAPPER_CACHE_REGISTER (feed_url, new_origin_uri, hdr, old_last_modified, download_size, load_msec);
	ret_flag := -1;
no_feed:;
    }
  -- generic xHTML, extraction as per our ontology
  xt := xt_sav;
  if (add_html_meta = 1 and xpath_eval ('/html', xt) is not null)
    {
      xd := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/html2rdf.xsl', xt, vector ('base', coalesce (dest, graph_iri)));
      if (xpath_eval ('count(/RDF/*)', xd) > 0)
        {
	  mdta := mdta + 1;
          xd := serialize_to_UTF8_xml (xd);
          DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
	}
    }
ret:
  if (mdta > 0 and aq is not null)
    aq_request (aq, 'DB.DBA.RDF_SW_PING', vector (ps, new_origin_uri));

  declare ord any;
  ord := (select RM_ID from DB.DBA.SYS_RDF_MAPPERS where RM_HOOK = 'DB.DBA.RDF_LOAD_HTML_RESPONSE');
  for select RM_PATTERN from DB.DBA.SYS_RDF_MAPPERS where RM_ID > ord and RM_TYPE = 'URL' and RM_ENABLED = 1 order by RM_ID do
    {
      if (regexp_match (RM_PATTERN, new_origin_uri) is not null)
        mdta := 0;
    }

  return (mdta * ret_flag);
  no_microformats:;
  return 0;
}
;

-- /* convert the feed in rss 1.0 format to sioc */
create procedure DB.DBA.RDF_LOAD_FEED_SIOC (in content any, in iri varchar, in graph_iri varchar)
{
  declare xt, xd any;
  declare exit handler for sqlstate '*'
    {
      goto no_sioc;
    };
  xt := xtree_doc (content);
  xd := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/feed2sioc.xsl', xt, vector ('base', graph_iri));
  xd := serialize_to_UTF8_xml (xd);
  DB.DBA.RDF_LOAD_RDFXML (xd, iri, graph_iri);
  no_sioc:
  return;
}
;

registry_set ('__sparql_sponge_use_w3c_xslt', 'on')
;


create procedure DB.DBA.SYS_URN_SPONGE_UP (in local_iri varchar, in get_uri varchar, in options any)
{
  if (lower (local_iri) like 'urn:lsid:%')
    {
      options := vector_concat (vector ('get:uri', 'http://lsid.tdwg.org/'||get_uri), options);
      return DB.DBA.SYS_HTTP_SPONGE_UP (local_iri, get_uri,
	  'DB.DBA.RDF_LOAD_HTTP_RESPONSE', 'DB.DBA.RDF_FORGET_HTTP_RESPONSE', options);
    }
  else
    {
      signal ('RDFZZ', 'This version of Virtuoso Sponger do not support "urn" IRI scheme');
    }
}
;

create procedure DB.DBA.SYS_DOI_SPONGE_UP (in local_iri varchar, in get_uri varchar, in options any)
{
  if (lower (local_iri) like 'doi:%' and __proc_exists ('HS_Resolve', 2) is not null)
    {
      declare new_get_uri varchar;
      new_get_uri := HS_Resolve (substring (get_uri, 5, length (get_uri)));
      if (new_get_uri is null)
        signal ('RDFZZ', 'Cannot resolve IRI='||get_uri);
      options := vector_concat (vector ('get:uri', new_get_uri), options);
      return DB.DBA.SYS_HTTP_SPONGE_UP (local_iri, get_uri,
	  'DB.DBA.RDF_LOAD_HTTP_RESPONSE', 'DB.DBA.RDF_FORGET_HTTP_RESPONSE', options);
    }
  else
    {
      signal ('RDFZZ', 'This version of Virtuoso Sponger do not support "doi" IRI scheme');
    }
}
;

create procedure DB.DBA.RDF_LOAD_YAHOO_STOCK_DATA (in graph_iri varchar, in new_origin_uri varchar,  in dest varchar,
    inout _ret_body any, inout aq any, inout ps any, inout _key any, inout opts any)
{
  declare meta, tmp, content varchar;
  declare symbol varchar;
  declare arr any;

  declare exit handler for sqlstate '*'
    {
--      dbg_obj_print (__SQL_MESSAGE);
      return 0;
    };
--  dbg_obj_print ('DB.DBA.RDF_LOAD_YAHOO_TRAFFIC_DATA');
  arr := sprintf_inverse (new_origin_uri, 'http://finance.yahoo.com/q?s=%s', 0);
  symbol := arr[0];

  rdfm_yq_get_quote (symbol, new_origin_uri, dest, graph_iri);
  rdfm_yq_get_history (symbol, new_origin_uri, dest, graph_iri);
  rdfm_yq_get_feed (symbol, new_origin_uri, dest, graph_iri);
  rdfm_yq_get_events (symbol, new_origin_uri, dest, graph_iri);
  rdfm_yq_get_mb (symbol, new_origin_uri, dest, graph_iri);
  rdfm_yq_get_competitors (symbol, new_origin_uri, dest, graph_iri);
  return 1;
}
;


create procedure rdfm_yq_get_quote (in symbol varchar, in new_origin_uri varchar, in  dest varchar, in graph_iri varchar)
{
  declare arr, cnt, ses, content any;
  declare xt, xd any;

  ses := string_output ();
  cnt := http_get (sprintf ('http://download.finance.yahoo.com/d/quotes.csv?s=%U&f=nsbavophg&e=.csv', symbol));
  arr := rdfm_yq_parse_csv (cnt);
  http ('<quote stock="NASDAQ">', ses);
  foreach (any q in arr) do
    {
      http_value (q[0], 'company', ses);
      http_value (q[1], 'symbol', ses);
      http_value (q[2], 'bid', ses);
      http_value (q[3], 'ask', ses);
      http_value (q[4], 'volume', ses);
      http_value (q[5], 'open', ses);
      http_value (q[6], 'prev.close', ses);
      http_value (q[7], 'high', ses);
      http_value (q[8], 'low', ses);
    }
  http ('</quote>', ses);
  content := string_output_string (ses);
  xt := xtree_doc (content);
  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/yahoo_stock2rdf.xsl', xt,
	  vector ('baseUri', 'http://finance.yahoo.com/q?s='||symbol));
  xd := serialize_to_UTF8_xml (xt);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
  return;
}
;

create procedure rdfm_yq_get_history (in symbol varchar, in new_origin_uri varchar, in  dest varchar, in graph_iri varchar)
{
  declare arr, cnt, ses, content any;
  declare xt, xd any;

  ses := string_output ();
  cnt := http_get (sprintf ('http://ichart.finance.yahoo.com/table.csv?s=%U&d=10&e=13&f=2007&g=d&a=8&b=7&c=2007&ignore=.csv', symbol));
  arr := rdfm_yq_parse_csv (cnt);
--  dbg_obj_print (arr);
  http (sprintf ('<history stock="NASDAQ" symbol="%V">', symbol), ses);
  foreach (any q in arr) do
    {
      if (q[0] <> 'Date')
	{
	  http ('<hist-price>', ses);
	  http_value (q[0], 'date', ses);
	  http_value (q[1], 'open', ses);
	  http_value (q[2], 'high', ses);
	  http_value (q[3], 'low', ses);
	  http_value (q[4], 'close', ses);
	  http_value (q[5], 'volume', ses);
	  http_value (q[6], 'adjclose', ses);
	  http ('</hist-price>', ses);
	}
    }
  http ('</history>', ses);
  content := string_output_string (ses);
  xt := xtree_doc (content);
  xt := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/yahoo_stock2rdf.xsl', xt, vector ('baseUri', 'http://finance.yahoo.com/q/hp?s='||symbol));
  xd := serialize_to_UTF8_xml (xt);
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
  return;
}
;

create procedure rdfm_yq_date_cvt (in d varchar)
{
  declare arr any;
  declare dt any;
  declare exit handler for sqlstate '*'
    {
      return null;
    };
  arr := sprintf_inverse (trim (cast (d as varchar)), '%d-%s-%d', 0);
  if (length(arr) < 3)
    return null;
  dt := http_string_date (sprintf ('Mon, %02d %s 20%02d 00:00:00 GMT', arr[0], arr[1], arr[2]));
  dt := dt_set_tz (dt, 0);
  return date_iso8601 (dt);
}
;

create procedure rdfm_yq_get_competitors (in symbol varchar, in new_origin_uri varchar, in  dest varchar, in graph_iri varchar)
{
  declare content, iri any;
  declare xt, xd, xp, ses any;
  content := http_get (sprintf ('http://finance.yahoo.com/q/co?s=%U', symbol));
  --content := file_to_string ('temp/xx');
  xt := xtree_doc (content, 2);
  xp := xpath_eval ('//table[tr/td/small/b[ contains (., "DIRECT COMPETITOR COMPARISON")]]/following-sibling::table[2]/tr[1]/td/table/tr[1]//a/text()', xt, 0);
--  dbg_obj_print (xp);
  ses := string_output ();
  foreach (any x in xp) do
    {
      x := cast (x as varchar);
      if (x <> symbol and x <> 'Industry')
	{
	  http (sprintf ('<http://dbpedia.org/resource/%s> <http://xbrlontology.com/ontology/finance/stock_market#hasCompetitor> <http://dbpedia.org/resource/%s> .\n', symbol, x), ses);
	  http (sprintf ('<http://dbpedia.org/resource/%s> <http://www.w3.org/2000/01/rdf-schema#isDefinedBy> <http://finance.yahoo.com/q?s=%s> .\n', x, x), ses);
	}
    }
  content := string_output_string (ses);
--  dbg_obj_print (content);
  TTLP (content, new_origin_uri, coalesce (dest, graph_iri));
  return;
}
;

create procedure rdfm_yq_get_events (in symbol varchar, in new_origin_uri varchar, in  dest varchar, in graph_iri varchar)
{
  declare content, iri any;
  declare xt, xd, xp, ses any;
  iri := sprintf ('http://finance.yahoo.com/q/ce?s=%U', symbol);
  content := http_get (sprintf ('http://finance.yahoo.com/q/ce?s=%U', symbol));
  xt := xtree_doc (content, 2);
  xp := xpath_eval ('//table[tr/td[@class="yfnc_tablehead1" and normalize-space (.) = "Event"]]/tr', xt, 0);
  ses := string_output ();
  http ('<r:RDF xmlns:r="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:c="http://www.w3.org/2002/12/cal/icaltzd#">\n', ses);
  http (sprintf ('<c:Vcalendar r:about="http://finance.yahoo.com/q/ce?s=%V#this">\n', symbol), ses);
  http ('<c:prodid>-//connolly.w3.org//palmagent 0.6 (BETA)//EN</c:prodid>\n', ses);
  http ('<c:version>2.0</c:version>\n', ses);
  foreach (any x in xp) do
    {
      declare _time, _desc, _uri varchar;
      _time := xpath_eval ('string(td[1])', x);
      _desc := xpath_eval ('string(td[2])', x);
      _uri :=  xpath_eval ('td[2]/a/@href', x);
      --dbg_obj_print (_time, _desc, _uri);
      if (length (_time) and length (_desc))
	{
	  _time := rdfm_yq_date_cvt (_time);
	  if (length (_time))
	    {
	      http ('<c:component>\n', ses);
	      http ('<c:Vevent>\n', ses);
	      http (sprintf ('<c:description>%V</c:description>\n', _desc), ses);
	      http (sprintf ('<c:dtstart r:datatype="http://www.w3.org/2001/XMLSchema#dateTime">%V</c:dtstart>\n', _time), ses);
	      if (_uri is not null)
		http (sprintf ('<c:url r:resource="%V"/>\n', _uri), ses);
	      http ('</c:Vevent>\n', ses);
	      http ('</c:component>\n', ses);
	    }
	}
    }
  http ('</c:Vcalendar>\n', ses);
  http ('</r:RDF>\n', ses);
  content := string_output_string (ses);
  --dbg_printf ('%s', content);
  DB.DBA.RDF_LOAD_RDFXML (content, new_origin_uri, coalesce (dest, graph_iri));
  return;
}
;

create procedure rdfm_yq_get_mb (in symbol varchar, in new_origin_uri varchar, in  dest varchar, in graph_iri varchar)
{
  declare content, hdr any;
  declare xt, xp any;
  content := http_get ('http://messages.finance.yahoo.com/mb/'||symbol);
  xt := xtree_doc (content, 2);
  xp := cast(xpath_eval ('//a[normalize-space(.) = "RSS"]/@href', xt) as varchar);
  if (length (xp))
    {
      content := RDF_HTTP_URL_GET (xp, '', hdr);
      rdfm_yq_load_feed (content, new_origin_uri, dest, graph_iri);
    }
}
;

create procedure rdfm_yq_load_feed (inout content any, in new_origin_uri varchar, in  dest varchar, in graph_iri varchar)
{
  declare xt, xd any;
  xt := xtree_doc (content);
  if (xpath_eval ('/RDF', xt) is not null and content is not null)
    {
      xd := content;
      goto ins_rdf;
    }
  else if (xpath_eval ('/feed', xt) is not null)
    {
      xd := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/atom2rdf.xsl', xt);
    }
  else if (xpath_eval ('/rss', xt) is not null)
    {
      xd := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/rss2rdf.xsl', xt);
    }
  else
    goto no_feed;
  xd := serialize_to_UTF8_xml (xd);
  ins_rdf:
  DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
  DB.DBA.RDF_LOAD_FEED_SIOC (xd, new_origin_uri, coalesce (dest, graph_iri));
  no_feed:
  return;
}
;

create procedure rdfm_yq_get_feed (in symbol varchar, in new_origin_uri varchar, in  dest varchar, in graph_iri varchar)
{
  declare content, hdr any;
  content := RDF_HTTP_URL_GET (sprintf ('http://us.rd.yahoo.com/finance/news/rss/add/*http://finance.yahoo.com/rss/SeekingAlpha?s=%U', symbol), '', hdr);
  rdfm_yq_load_feed (content, new_origin_uri, dest, graph_iri);
  return;
}
;


create procedure rdfm_yq_parse_csv (in str varchar)
{
  declare ses any;
  declare ret, line, v any;

  ses := string_output ();
  http (str, ses);
  ret := vector ();
  while (1)
    {
      line := ses_read_line (ses, 0, 0, 1);
      if (not isstring (line))
	goto finish;
      line := replace (line, '\r', '\n');
      line := replace (line, '\n\n', '\n');
      v := rdfm_yq_parse_csv_line (line);
--      dbg_obj_print (v);
      ret := vector_concat (ret, vector (v));
    }
  finish:
  return ret;
}
;

create procedure rdfm_yq_parse_csv_line (inout line varchar)
{
  declare res any;
  declare len, i, stat, prev int;
  declare tmp varchar;

  res := vector ();
  len := length (line);
  stat := 0;
  tmp := '';
  prev := 0;
  for (i := 0; i < len; i := i + 1)
    {
      if (stat = 0 and (line[i] = ascii (',') or line[i] = ascii ('\n')))
	{
	  res := vector_concat (res, vector (tmp));
	  tmp := '';
	}
      else if (line[i] = ascii ('"'))
	{
	  if (stat = 1)
	    {
	      stat := 0;
	    }
	  else if (stat = 0)
	    {
	      if (prev = line[i])
	        tmp := tmp || chr (line[i]);
              stat := 1;
	    }
	}
      else if (stat)
	tmp := tmp || chr (line[i]);
      else if (stat = 1 and line[i] = ascii (' '))
        tmp := tmp || ' ';
      else if (stat = 0 and line[i] <> ascii (' '))
        tmp := tmp || chr (line[i]);
      prev := line[i];
    }
  return res;
}
;


create procedure RDFM_IDENT_RESOLVE_INIT ()
{
  declare cnt, hdr, url, xt, xp, sch, delim any;
  for select OS_ID as _id, OS_SERVER as _server from DB.DBA.OAI_SERVERS do
    {
      xp := sch := delim := '';
      declare exit handler for sqlstate '*'
	{
	  update DB.DBA.OAI_SERVERS set OS_ENABLED = 0 where OS_ID = _id;
	  goto try_next;
	};
      url := _server || '?verb=Identify';
      commit work;
      cnt := RDF_HTTP_URL_GET (url, _server, hdr);
      xt := xtree_doc (cnt);
      xp := xpath_eval ('string (/OAI-PMH/Identify/description/oai-identifier/repositoryIdentifier)', xt);
      sch := xpath_eval ('string (/OAI-PMH/Identify/description/oai-identifier/scheme)', xt);
      delim := xpath_eval ('string (/OAI-PMH/Identify/description/oai-identifier/delimiter)', xt);
      if (length (xp))
        update DB.DBA.OAI_SERVERS set OS_URN_PATTERN = sch||delim||xp, OS_ENABLED = 1 where OS_ID = _id;
      else
	update DB.DBA.OAI_SERVERS set OS_ENABLED = 0 where OS_ID = _id;
      try_next:;
--      dbg_obj_print (_server, sch||delim||xp);
    }
}
;

create procedure DB.DBA.SYS_OAI_SPONGE_UP (in local_iri varchar, in get_uri varchar, in options any)
{
  declare url, hdr, xt, xd, cnt any;
  declare new_origin_uri, dest, graph_iri varchar;
  new_origin_uri := cast (get_keyword_ucase ('get:uri', options, get_uri) as varchar);
  graph_iri := get_uri;
  dest := get_keyword_ucase ('get:destination', options);
  for select OS_SERVER as _server from DB.DBA.OAI_SERVERS where get_uri like OS_URN_PATTERN || ':%' and OS_ENABLED = 1 do
    {
      declare exit handler for sqlstate '*'
	{
	  return local_iri;
	};
      url := sprintf ('%s?verb=GetRecord&identifier=%s&metadataPrefix=oai_dc', _server, get_uri);
      cnt := RDF_HTTP_URL_GET (url, _server, hdr);
      xt := xtree_doc (cnt);
--      dbg_obj_print (cnt);
      xd := DB.DBA.RDF_MAPPER_XSLT (registry_get ('_rdf_mappers_path_') || 'xslt/oai2rdf.xsl', xt, vector ('baseUri', get_uri));
      xd := serialize_to_UTF8_xml (xd);
--      dbg_obj_print (xd);
      if (dest is null)
	delete from DB.DBA.RDF_QUAD where G = DB.DBA.RDF_MAKE_IID_OF_QNAME (graph_iri);
      DB.DBA.RDF_LOAD_RDFXML (xd, new_origin_uri, coalesce (dest, graph_iri));
    }
  return local_iri;
}
;

create procedure DB.DBA.LOAD_RDF_MAPPER_XBRL_ONTOLOGIES()
{
  declare urihost varchar;
  urihost := cfg_item_value(virtuoso_ini_path(), 'URIQA','DefaultHost');
  for select cast (RES_CONTENT as varchar) as content1 from WS.WS.SYS_DAV_RES where RES_FULL_PATH like '/DAV/VAD/rdf_mappers/ontologies/xbrl/%.owl' do
  {
    DB.DBA.RDF_LOAD_RDFXML (content1, 'http://demo.openlinksw.com/schemas/xbrl#', 'http://demo.openlinksw.com/schemas/RDF_Mapper_Ontology/1.0/');
  }
}
;

DB.DBA.LOAD_RDF_MAPPER_XBRL_ONTOLOGIES()
;

drop procedure DB.DBA.LOAD_RDF_MAPPER_XBRL_ONTOLOGIES
;

create procedure DB.DBA.GET_XBRL_CANONICAL_NAME(in elem varchar) returns varchar
{
    declare cur varchar;
    cur := 'http://demo.openlinksw.com/schemas/xbrl#' || elem;
    if (exists (sparql ask from <http://demo.openlinksw.com/schemas/RDF_Mapper_Ontology/1.0/> {`iri(?:cur)` a rdf:Property } ) )
        return elem;
    else
        return NULL;
}
;

grant execute on DB.DBA.GET_XBRL_CANONICAL_NAME to public
;

xpf_extension ('http://www.openlinksw.com/virtuoso/xslt:xbrl_canonical_name', fix_identifier_case ('DB.DBA.GET_XBRL_CANONICAL_NAME'))
;

DB.DBA.URLREWRITE_CREATE_REGEX_RULE(
'xbrl_rule1', 
1, 
'/schemas/xbrl#(.*)', 
vector('path'), 
1, 
'/sparql?query=DESCRIBE%20%3Chttp%3A//localhost:9301/schemas/xbrl%23%U%3E%20FROM%20%3Chttp%3A//localhost:9301/schemas/RDF_Mapper_Ontology/1.0/%3E',
vector('path'), 
null, 
'(text/rdf.n3)|(application/rdf.xml)', 
0, 
null 
);

DB.DBA.URLREWRITE_CREATE_RULELIST (
'xbrl_rule_list1',
1,
vector('xbrl_rule1')
);

DB.DBA.VHOST_REMOVE (lpath=>'/schemas/xbrl#');
DB.DBA.VHOST_REMOVE (lpath=>'/schemas/xbrl');

DB.DBA.VHOST_DEFINE (lpath=>'/schemas/xbrl#', ppath=>'/DAV/VAD/rdf_mappers/ontologies/xbrl/msft2007.owl', vsp_user=>'dba', is_dav=>1, is_brws=>0, opts=>vector ('url_rewrite', 'xbrl_rule_list1'));

DB.DBA.VHOST_DEFINE (lpath=>'/schemas/xbrl', ppath=>'/DAV/VAD/rdf_mappers/ontologies/xbrl/msft2007.owl', vsp_user=>'dba', is_dav=>1, is_brws=>0, opts=>vector ('url_rewrite', 'xbrl_rule_list1'));
