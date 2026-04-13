workspace {
    model {
        customer = person "Customer" "Browses restaurants and menus online, adds items to cart, orders and tracks delivery status."
        restaurantAdmin = person "Restaurant Admin" "Manages menus, orders and promotions for the restaurant."
        quickOrder = softwareSystem "QuickOrder" "Online order management platform for small restaurants and street food venues." {
            tags "Central System"
        }
        paymentProvider = softwareSystem "External Payment Provider" "Processes secure card payments for online orders."
        notificationService = softwareSystem "Notification Service" "Sends order status update notifications when needed."

        customer -> quickOrder "Places orders and tracks status"
        restaurantAdmin -> quickOrder "Manages restaurant orders and menus"
        quickOrder -> paymentProvider "Initiates card payment processing"
        quickOrder -> notificationService "Sends order status updates"
    }

    views {
        systemContext quickOrder {
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