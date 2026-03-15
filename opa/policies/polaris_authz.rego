package polaris.authz

import future.keywords.if
import future.keywords.in

default allow := false

# Root principal bypasses all authorization checks
allow if {
    input.actor.principal == "root"
}

# Admin role can perform all catalog, namespace, and table operations
allow if {
    "ADMIN" in input.actor.roles
    input.action in [
        # Catalog operations
        "CREATE_CATALOG",
        "UPDATE_CATALOG",
        "DELETE_CATALOG",
        "LIST_CATALOGS",

        # Namespace operations
        "CREATE_NAMESPACE",
        "UPDATE_NAMESPACE_PROPERTIES",
        "DROP_NAMESPACE",
        "LIST_NAMESPACES",
        "READ_NAMESPACE_METADATA",

        # Table operations
        "CREATE_TABLE_DIRECT",
        "LOAD_TABLE_WITH_READ_DELEGATION",
        "LOAD_TABLE_WITH_WRITE_DELEGATION",
        "UPDATE_TABLE",
        "DROP_TABLE_WITHOUT_PURGE",
        "LIST_TABLES"
    ]
}

# Data engineers can create/read/update tables and namespaces, but not catalogs
allow if {
    "DATA_ENGINEER" in input.actor.roles
    input.action in [
        # Table operations
        "CREATE_TABLE_DIRECT",
        "LOAD_TABLE_WITH_READ_DELEGATION",
        "LOAD_TABLE_WITH_WRITE_DELEGATION",
        "UPDATE_TABLE",
        "LIST_TABLES",

        # Namespace operations
        "CREATE_NAMESPACE",
        "UPDATE_NAMESPACE_PROPERTIES",
        "LIST_NAMESPACES",
        "READ_NAMESPACE_METADATA",
        
        # Catalogs
        "LIST_CATALOGS"
    ]
}

# Analysts can only read tables and namespaces
allow if {
    "ANALYST" in input.actor.roles
    input.action in [
        "LOAD_TABLE_WITH_READ_DELEGATION",
        "LIST_TABLES",
        "LIST_NAMESPACES",
        "READ_NAMESPACE_METADATA",
        "LIST_CATALOGS"
    ]
}
