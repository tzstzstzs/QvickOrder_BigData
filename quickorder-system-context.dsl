workspace {
    model {
        customer = person "Customer" "Browses restaurants and menus online, adds items to cart, orders and tracks delivery status."
        restaurantAdmin = person "Restaurant Admin" "Manages menus, orders and promotions for the restaurant."
        quickOrder = softwareSystem "QuickOrder" "Online order management platform for small restaurants and street food venues." {
            tags "Central System"
            webApp = container "Web Application" "Single-page web application used by customers and restaurant admins through a browser." "React"
            mobileApp = container "Mobile Application" "Cross-platform mobile client for customers to browse restaurants, place orders and track status." "React Native"
            backend = container "Application Backend" "Modular monolith backend handling browsing, cart, orders, payment coordination and admin workflows." "Node.js"
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
        backend -> database "Reads from and writes to"
        backend -> paymentProvider "Processes card payments"
        backend -> notificationService "Sends order status updates"
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