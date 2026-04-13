workspace {
    model {
        customer = person "Customer" "Browses restaurants and menus online, adds items to cart, orders and tracks delivery status."
        restaurantAdmin = person "Restaurant Admin" "Manages menus, orders and promotions for the restaurant."
        quickOrder = softwareSystem "QuickOrder" "Online order management platform for small restaurants and street food venues." {
            tags "Central System"
            webApp = container "Web Application" "Single-page web application used by customers and restaurant admins through a browser." "React"
            mobileApp = container "Mobile Application" "Cross-platform mobile client for customers to browse restaurants, place orders and track status." "React Native"
            backend = container "Application Backend" "Modular monolith backend handling browsing, cart, orders, payment coordination and admin workflows." "Node.js" {
                catalogApi = component "Catalog API" "Handles restaurant and menu browsing requests." "REST Controller"
                orderApi = component "Order API" "Handles customer order placement and status requests." "REST Controller"
                adminApi = component "Admin API" "Handles restaurant admin operations for menus, orders and promotions." "REST Controller"

                cartService = component "Cart Application Service" "Manages cart workflows and checkout preparation." "Application Service"
                orderService = component "Order Application Service" "Coordinates order placement, tracking and fulfillment processes." "Application Service"
                paymentService = component "Payment Application Service" "Coordinates payment authorization and confirmation workflows." "Application Service"
                restaurantAdminService = component "Restaurant Admin Application Service" "Executes restaurant menu, order and promotion management workflows." "Application Service"

                catalogDomain = component "Catalog Domain Module" "Business rules for restaurants and menu items." "Domain Service"
                cartDomain = component "Cart Domain Module" "Business rules for cart validation, pricing and persistence." "Domain Service"
                orderDomain = component "Order Domain Module" "Business rules for order lifecycle and status transitions." "Domain Service"

                paymentAdapter = component "Payment Integration Adapter" "Integrates with external payment provider for card payments." "Integration Adapter"
                notificationAdapter = component "Notification Integration Adapter" "Sends order update notifications through external service." "Integration Adapter"
                repository = component "Repository Layer" "Manages persistence of restaurants, carts, orders, users and promotions." "Repository"
            }
            database = container "Database" "Relational database for restaurants, menus, carts, orders, users, promotions and payment records." "PostgreSQL"
        }
        paymentProvider = softwareSystem "External Payment Provider" "Processes secure card payments for online orders."
        notificationService = softwareSystem "Notification Service" "Sends order status update notifications when needed."

        customer -> quickOrder "Places orders and tracks status"
        restaurantAdmin -> quickOrder "Manages restaurant orders and menus"
        customer -> webApp "Uses web application"
        customer -> mobileApp "Uses mobile application"
        restaurantAdmin -> webApp "Uses web application"
        webApp -> backend "Calls backend APIs for ordering and admin tasks"
        mobileApp -> backend "Calls backend APIs for browsing and tracking"

        webApp -> catalogApi "Calls catalog browsing APIs"
        webApp -> orderApi "Calls order placement and status APIs"
        webApp -> adminApi "Calls restaurant admin APIs"
        mobileApp -> catalogApi "Calls restaurant browsing and order APIs"
        mobileApp -> orderApi "Calls order status and checkout APIs"

        catalogApi -> catalogDomain "Processes browsing requests"
        orderApi -> orderService "Delegates order workflows"
        orderApi -> cartService "Validates cart during checkout"
        adminApi -> restaurantAdminService "Delegates admin workflows"

        cartService -> cartDomain "Applies cart business rules"
        orderService -> orderDomain "Applies order lifecycle rules"
        restaurantAdminService -> catalogDomain "Applies catalog management rules"
        restaurantAdminService -> orderDomain "Applies order management rules"
        paymentService -> paymentAdapter "Coordinates payment forwarding"
        orderService -> paymentService "Requests payment processing"
        orderService -> notificationAdapter "Triggers order update notifications"

        catalogDomain -> repository "Accesses catalog data"
        cartDomain -> repository "Accesses cart and user data"
        orderDomain -> repository "Accesses order and transaction data"
        restaurantAdminService -> repository "Persists admin changes"
        paymentAdapter -> paymentProvider "Processes card payments"
        notificationAdapter -> notificationService "Sends order status updates"
        repository -> database "Reads from and writes to"
    }

    views {
        systemContext quickOrder {
            include *
            autolayout lr
        }

        container quickOrder {
            include customer
            include restaurantAdmin
            include webApp
            include mobileApp
            include backend
            include database
            include paymentProvider
            include notificationService
            autolayout lr
        }

        component backend {
            include *
            autolayout lr
        }

        styles {
            element "Central System" {
                background #1168bd
                color #ffffff
                shape roundedBox
            }
            element Person {
                background #08427b
                color #ffffff
                shape person
            }
            element SoftwareSystem {
                background #438dd5
                color #ffffff
            }
        }
    }
}