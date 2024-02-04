##### Default Configuration #####
aws_region = "us-east-2"
aws_region_shot = "ue2"
environment = "shd"
service_name = "naemo"

### users ###
users = {
  rosa = { id="rosa@lgcns.com",role="developers" },  // 김로사 
	bhlim = { id="bhlim@lgcns.com",role="developers" },  // 임보혁
	blingsurio = { id="blingsurio@lgcns.com",role="admins" }, // 전탁공
	kmz765 = { id="kmz765@lgcns.com",role="admins" },  // 김경미
  skrho = { id="skrho@lgcns.com",role="admins" },      // 노승갑
  jgikim = { id="jgikim@lgcns.com",role="architectures" },     // 김종기
  okmikyung = { id="okmikyung@lgcns.com",role="architectures" },  // 조미경
	young_86 = { id="young_86@lgcns.com",role="developers" },      // 임영란
  hwangsj124 = { id="hwangsj124@lgcns.com",role="developers" },    // 황석진
  heybys1 = { id="heybys1@lgcns.com",role="developers" },       // 변영석
  yongtae010 = { id="yongtae010@lgcns.com",role="developers" },    // 김용태
  heybys1 = { id="heybys1@lgcns.com",role="developers" },       // 변영석
  blue1day = { id="blue1day@lgcns.com",role="developers" },      // 한호연
  giwoongjung = { id="giwoongjung@lgcns.com",role="developers" },   // 정기웅
  booski = { id="booski@lgcns.com",role="developers" },        // 박병훈
  yooncheol14 = { id="yooncheol14@lgcns.com",role="developers" },   // 김윤철
  dnqudtjs = { id="dnqudtjs@lgcns.com",role="architectures" },   // 우병선
  woongkyuham = { id="woongkyuham@lgcns.com",role="developers" },   // 함응규
  yo_onji = { id="yo_onji@lgcns.com",role="developers" },       // 김윤철
  ksthink = { id="ksthink@lgcns.com",role="developers" },         // 장광수
  taesik = { id="Taesik.Shin@lgcns.com",role="architectures" },// 신태식
  lion = { id="lion@lgcns.com",role="architectures" },          // 이호  
  han909079 = { id="han909079@lgcns.com",role="developers" },     // 김원정  
  jooncco = { id="jooncco@lgcns.com",role="developers" },       // 정준하  
  sehoon = { id="sehoon@lgcns.com",role="developers" },        // 김세훈
  namezin = { id="namezin@lgcns.com",role="developers" },       // 서준형
  eastflag = { id="eastflag@cnspartner.com",role="developers" }, // 이동기
  shinkj = { id="shinkj@lgcns.com",role="developers" },         // 신경준
  changunHa = { id="changun.Ha@lgcns.com",role="developers" },  // 하창언
  ralra1108 = { id="ralra1108@lgcns.com",role="developers" },  // 나혜정
  changHee0206 = { id="ChangHee0206@lgcns.com",role="developers" },  // 조창희
  korsuk = { id="korsuk@lgcns.com",role="developers" },  // 최용석
  rlaghdcjf12 = { id="rlaghdcjf12@lgcns.com",role="developers" },  // 김홍철
  leejo95 = { id="leejo95@lgcns.com",role="developers" },  // 이종오
  sungae0620 = { id="sungae0620@lgcns.com",role="architectures" },  // 임성애
  yoonkyung = { id="yoonkyung@lgcns.com",role="developers" },  // 이윤경
  aerinlee = { id="aerin.lee@lgcns.com",role="developers" },  // 이애린
  skybae17 = { id="skybae17@lgcns.com",role="developers" },  // 배하늘
  yoonjungOH = { id="yoonjungOH@lgcns.com",role="admins" },  // 오윤정
  gunjai = { id="gunjai@lgcns.com",role="developers" },  // 이건재
  hyunjuj = { id="hyunju.j@lgcns.com",role="developers" },  // 전현주
  jgkang = { id="jg.kang@lgcns.com",role="developers" },  // 강재구
  jinwoo_an = { id="jinwoo_an@lgcns.com",role="developers" },  // 안진우
  youngilkim = { id="youngil.kim@lgcns.com",role="developers" },  // 김영일
  sejongpark = { id="sejong.park@lgcns.com",role="developers" },  // 박세종
  chaboom = { id="chaboom@lgcns.com",role="developers" },  // 차범석
  byungwookko = { id="byungwook.ko@lgcns.com",role="developers" },  // 고병욱
  A74571park = { id="A74571park@cnspartner.com",role="developers" },  // 박지환
  a74572son = { id="a74572son@cnspartner.com",role="developers" },  // 손성일
  JaeSeok = { id="JaeSeok@lgcns.com",role="architectures" },  // 임재석
  belltenlee = { id="bellten.lee@lgcns.com",role="architectures" },  // 이종열
  mkc = { id="mkc@lgcns.com",role="developers" },  // 조민경
  smhan = { id="smhan@bithumbmeta.io",role="architectures" },  // 한성만
  jeeyeon = { id="jeeyeon.park@lgcns.com",role="developers" },  // 박지연
  breezy = { id="breezy@bithumbmeta.io",role="security" },  // 최민호
  jaemmani = { id="jaemmani@bithumbmeta.io",role="admins" },  // 김재만
  jihoonshin = { id="jihoon.shin@bithumbmeta.io",role="security" },  // 신재훈
  jiyou = { id="ji.you@bithumbmeta.io",role="developers" },  // 유지현
  pjhnocegood = { id="pjhnocegood@bithumbmeta.io",role="developers" },  // 박진환
  jhlee0812 = { id="jhlee0812@lgcns.com",role="admins" },  // 이재혁
  shbae = { id="sh.bae@bithumbmeta.io",role="developers" },  // 배성현
  point455 = { id="point455@bithumbmeta.io",role="architectures" },  // 이기섭
  hsm3394 = { id="hsm3394@bithumbmeta.io",role="architectures" },  // 한상민
  insgrim = { id="insgrim@cnspartner.com",role="architectures" },  // 조윤호
  kyk4334 = { id="kyk4334@bithumbmeta.io",role="developers" },  // 강영규
  myeongjin = { id="myeongjin@lgcns.com",role="developers" }  // 이명진
}

### iam groups ###
groups = {
  developers = {
    name = "developers",
  	assume_roles = ["arn:aws:iam::385866877617:role/Developer-AccountAccessRole", 
                    "arn:aws:iam::087942668956:role/Developer-AccountAccessRole", 
                    "arn:aws:iam::908317417455:role/Developer-AccountAccessRole"
                  ]
  },
  architectures = {
    name = "architectures",
  	assume_roles = ["arn:aws:iam::385866877617:role/Architecture-AccountAccessRole",
                    "arn:aws:iam::087942668956:role/Architecture-AccountAccessRole",
                    "arn:aws:iam::908317417455:role/Architecture-AccountAccessRole",
                    "arn:aws:iam::351894368755:role/Architecture-AccountAccessRole"
                  ]
  },
	admins = {
    name = "admins",
  	assume_roles = ["arn:aws:iam::385866877617:role/Admin-AccountAccessRole",
                    "arn:aws:iam::087942668956:role/Admin-AccountAccessRole",
                    "arn:aws:iam::908317417455:role/Admin-AccountAccessRole",
                    "arn:aws:iam::351894368755:role/Admin-AccountAccessRole"
                  ] 
  },
	security = {
    name = "security",
  	assume_roles = ["arn:aws:iam::385866877617:role/Security-AccountAccessRole",
                    "arn:aws:iam::087942668956:role/Security-AccountAccessRole",
                    "arn:aws:iam::908317417455:role/Security-AccountAccessRole",
                    "arn:aws:iam::351894368755:role/Security-AccountAccessRole"
                  ] 
  },
  bmeta_infra = {
    name = "BMETA-Infra",
  	assume_roles = ["arn:aws:iam::385866877617:role/BMETA-Developer-AccountAccessRole"]
  },
  bmeta_security = {
    name = "BMETA-Security",
  	assume_roles = ["arn:aws:iam::385866877617:role/BMETA-Developer-AccountAccessRole"]
  },
  bmeta_wallet = {
    name = "BMETA-Wallet",
  	assume_roles = ["arn:aws:iam::385866877617:role/BMETA-Developer-AccountAccessRole"]
  },
  bmeta_developer = {
    name = "BMETA-Developer",
  	assume_roles = ["arn:aws:iam::385866877617:role/Developer-AccountAccessRole"]
  }
}

### roles ###
dev_roles = {
  developer = {
    name = "Developer-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",
    policys = ["arn:aws:iam::aws:policy/ReadOnlyAccess", 
               "arn:aws:iam::385866877617:policy/Developer-AccountAccessPolicy",
              "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
              "arn:aws:iam::aws:policy/AmazonS3FullAccess", 
              "arn:aws:iam::aws:policy/AWSBatchFullAccess"
              ]
  },
  architecture = {
    name = "Architecture-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",    
    policys = ["arn:aws:iam::aws:policy/ReadOnlyAccess",
               "arn:aws:iam::385866877617:policy/Architecture-AccountAccessPolicy",
               "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
               "arn:aws:iam::aws:policy/AWSBatchFullAccess",
               "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess"
              ]
  },
  admin = {
    name = "Admin-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",    
    policys = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  },
  security = {
    name = "Security-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",
    policys = [
              "arn:aws:iam::aws:policy/ReadOnlyAccess"
              ]
  }
}

stg_roles = {
  developer = {
    name = "Developer-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",
    policys = ["arn:aws:iam::aws:policy/ReadOnlyAccess", 
              "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
              #"arn:aws:iam::385866877617:policy/ses-send-policy", 
              "arn:aws:iam::aws:policy/AmazonSNSFullAccess",
              "arn:aws:iam::aws:policy/CloudWatchFullAccess",
              "arn:aws:iam::aws:policy/AmazonS3FullAccess", 
              "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
              "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
              ]
  },
  architecture = {
    name = "Architecture-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",    
    policys = ["arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
               "arn:aws:iam::aws:policy/ReadOnlyAccess", 
               #"arn:aws:iam::385866877617:policy/ses-send-policy", 
               "arn:aws:iam::aws:policy/AmazonSNSFullAccess", 
               "arn:aws:iam::aws:policy/CloudWatchFullAccess", 
               "arn:aws:iam::aws:policy/AmazonS3FullAccess", 
               "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
               "arn:aws:iam::aws:policy/service-role/AWSBatchServiceEventTargetRole",
              #  "arn:aws:iam::087942668956:policy/ssm-readonly-policy",
               "arn:aws:iam::aws:policy/AmazonRDSFullAccess",
               "arn:aws:iam::aws:policy/AmazonMSKReadOnlyAccess"
              ]
  },
  admin = {
    name = "Admin-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",    
    policys = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  },
  security = {
    name = "Security-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",
    policys = [
              "arn:aws:iam::aws:policy/ReadOnlyAccess"
              ]
  }
}

prd_roles = {
  developer = {
    name = "Developer-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",
    policys = ["arn:aws:iam::aws:policy/ReadOnlyAccess", 
              "arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
              #"arn:aws:iam::385866877617:policy/ses-send-policy", 
              "arn:aws:iam::aws:policy/AmazonSNSFullAccess",
              "arn:aws:iam::aws:policy/CloudWatchLogsReadOnlyAccess",
              "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
              "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
              ]
  },
  architecture = {
    name = "Architecture-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",    
    policys = ["arn:aws:iam::aws:policy/AmazonCognitoPowerUser",
               "arn:aws:iam::aws:policy/ReadOnlyAccess", 
               #"arn:aws:iam::385866877617:policy/ses-send-policy", 
               "arn:aws:iam::aws:policy/AmazonSNSFullAccess", 
               "arn:aws:iam::aws:policy/CloudWatchLogsReadOnlyAccess", 
               "arn:aws:iam::aws:policy/AmazonS3FullAccess", 
               "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
               "arn:aws:iam::aws:policy/service-role/AWSBatchServiceEventTargetRole",
              #  "arn:aws:iam::908317417455:policy/ssm-readonly-policy",
               "arn:aws:iam::aws:policy/AmazonRDSFullAccess",
               "arn:aws:iam::aws:policy/AmazonMSKReadOnlyAccess"
              ]
  },
  admin = {
    name = "Admin-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",    
    policys = ["arn:aws:iam::aws:policy/AdministratorAccess",
              "arn:aws:iam::aws:policy/AWSBillingReadOnlyAccess"
              ]
  },
  security = {
    name = "Security-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",
    policys = [
              "arn:aws:iam::aws:policy/ReadOnlyAccess"
              ]
  }
}

net_roles = {
  admin = {
    name = "Admin-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",    
    policys = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  },
  architecture = {
    name = "Architecture-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",    
    policys = ["arn:aws:iam::aws:policy/CloudFrontFullAccess",
               "arn:aws:iam::aws:policy/AWSLambda_FullAccess",
               "arn:aws:iam::aws:policy/CloudWatchLogsReadOnlyAccess"
              ]
  },
  security = {
    name = "Security-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",
    policys = [
              "arn:aws:iam::aws:policy/ReadOnlyAccess"
              ]
  }  
}

bmeta_dev_roles = {
  bmeta_developer = {
    name = "BMETA-Developer-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",
    policys = []
  },
  bmeta_architecture = {
    name = "BMETA-Architecture-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",    
    policys = []
  },
  bmeta_admin = {
    name = "BMETA-Admin-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",    
    policys = []
  },
  bmeta_security = {
    name = "BMETA-Security-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",
    policys = []
  },
  bmeta_wallet = {
    name = "BMETA-Wallet-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",
    policys = []
  }
}

bmeta_stg_roles = {
  bmeta_developer = {
    name = "BMETA-Developer-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",
    policys = []
  },
  bmeta_architecture = {
    name = "BMETA-Architecture-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",    
    policys = []
  },
  bmeta_admin = {
    name = "BMETA-Admin-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",    
    policys = []
  },
  bmeta_security = {
    name = "BMETA-Security-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",
    policys = []
  },
  bmeta_wallet = {
    name = "BMETA-Wallet-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",
    policys = []
  }
}

bmeta_prd_roles = {
  bmeta_developer = {
    name = "BMETA-Developer-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",
    policys = []
  },
  bmeta_architecture = {
    name = "BMETA-Architecture-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",    
    policys = []
  },
  bmeta_admin = {
    name = "BMETA-Admin-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",    
    policys = []
  },
  bmeta_security = {
    name = "BMETA-Security-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",
    policys = []
  },
  bmeta_wallet = {
    name = "BMETA-Wallet-AccountAccessRole",
    trust = "arn:aws:iam::676826599814:root",
    policys = []
  }
}
