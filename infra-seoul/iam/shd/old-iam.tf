## 기존 유저가 있기 때문에 기존 유저는 
## 아래 resource 테라폼 import 진행



#### infra team ####
resource "aws_iam_user" "infra1" {
  name = "lhb0209@bithumbmeta.io"
  path = "/"
}
resource "aws_iam_user" "infra2" {
  name = "jaemmani@bithumbmeta.io"
  path = "/"
}



#### qa team ####

resource "aws_iam_user" "qa1" {
  name = "woosang@bithumbmeta.io"
  path = "/"
}


#### secu team ####
resource "aws_iam_user" "secu1" {
  name = "jongoh.park@bithumbmeta.io"
  path = "/"
}

resource "aws_iam_user" "secu2" {
  name = "breezy@bithumbmeta.io"
  path = "/"
}


#### dev team ####
resource "aws_iam_user" "dev1" {
  name = "sh.bae@bithumbmeta.io"
  path = "/"
}

resource "aws_iam_user" "dev2" {
  name = "ji.you@bithumbmeta.io"
  path = "/"
}

resource "aws_iam_user" "dev3" {
  name = "kyk4334@bithumbmeta.io"
  path = "/"
}

resource "aws_iam_user" "dev4" {
  name = "pjhnocegood@bithumbmeta.io"
  path = "/"
}

resource "aws_iam_user" "dev5" {
  name = "hsm3394@bithumbmeta.io"
  path = "/"
}

resource "aws_iam_user" "dev6" {
  name = "point455@bithumbmeta.io"
  path = "/"
}

resource "aws_iam_user" "dev7" {
  name = "smhan@bithumbmeta.io"
  path = "/"
}

