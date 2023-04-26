resource "aws_route53_zone" "kateops" {
  name = "kateops.com"
}
resource "aws_route53_zone" "netzwolke" {
  name = "netzwolke.com"
}

resource "aws_ses_domain_identity" "kateops" {
  domain = aws_route53_zone.kateops.name
}


resource "aws_ses_domain_identity" "netzwolke" {
  domain = aws_route53_zone.netzwolke.name
}

resource "aws_route53_record" "kateops_ses" {
  name    = "_amazonses.${aws_route53_zone.kateops.name}"
  type    = "TXT"
  zone_id = aws_route53_zone.kateops.zone_id
  ttl     = "600"
  records = [aws_ses_domain_identity.kateops.verification_token]
}

resource "aws_route53_record" "netzwolke_ses" {
  name    = "_amazonses.${aws_route53_zone.netzwolke.name}"
  type    = "TXT"
  zone_id = aws_route53_zone.netzwolke.zone_id
  ttl     = "600"
  records = [aws_ses_domain_identity.netzwolke.verification_token]
}

resource "aws_ses_domain_dkim" "kateops" {
  domain = aws_ses_domain_identity.kateops.domain
}

resource "aws_ses_domain_dkim" "netzwolke" {
  domain = aws_ses_domain_identity.netzwolke.domain
}

resource "aws_route53_record" "kateops" {
  count   = 3
  zone_id = aws_route53_zone.kateops.zone_id
  name    = "${aws_ses_domain_dkim.kateops.dkim_tokens[count.index]}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${aws_ses_domain_dkim.kateops.dkim_tokens[count.index]}.dkim.amazonses.com"]
}

resource "aws_route53_record" "netzwolke" {
  count   = 3
  zone_id = aws_route53_zone.netzwolke.zone_id
  name    = "${aws_ses_domain_dkim.netzwolke.dkim_tokens[count.index]}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${aws_ses_domain_dkim.netzwolke.dkim_tokens[count.index]}.dkim.amazonses.com"]
}