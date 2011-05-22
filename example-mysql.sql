CREATE TABLE shares (
  id int(11) NOT NULL AUTO_INCREMENT,
  rem_host text NOT NULL,
  username text NOT NULL,
  our_result text,
  upstream_result text,
  reason text,
  solution text,
  PRIMARY KEY (id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

CREATE TABLE pool_worker (
  id int(11) NOT NULL AUTO_INCREMENT,
  username varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
