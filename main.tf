module "vpc" {
    source            =   "git::https://github.com/Vivekdevops1704/tf-module-vpc.git"
    for_each          =    var.vpc
    cidr              =    each.value["cidr"]
    subnets           =    each.value["subnets"]
    default_vpc_id    =    var.default_vpc_id
    default_vpc_cidr  =    var.default_vpc_cidr
    default_vpc_route_table_id = var.default_vpc_route_table_id
    tags              =    var.tags
    env               =    var.env
}

module "alb" {
    source            =   "git::https://github.com/Vivekdevops1704/tf-module-alb.git"
    for_each          =    var.alb
    internal          =    each.value["internal"]
    lb_type           =    each.value["lb_type"]
    sg_ingress_cidr   =    each.value["sg_ingress_cidr"]
    sg_port           =    each.value["sg_port"]
    subnets           =    each.value["internal"] ? local.app_subnets : data.aws_subnets.subnets.ids
    tags              =    var.tags
    env               =    var.env
    vpc_id            =    each.value["internal"] ? lookup(lookup(locals.vpc_id, "main", null), "public_subnet_ids ", null): var.private_subnet_ids 
}

module "docdb" {
    source            =   "git::https://github.com/Vivekdevops1704/tf-module-docdb.git"
    for_each          =    var.docdb
    
    tags              =    var.tags
    env               =    var.env
    
}