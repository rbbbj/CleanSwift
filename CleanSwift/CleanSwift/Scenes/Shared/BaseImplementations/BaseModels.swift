enum BaseModels {
    enum Error
    {
        struct Request
        {
        }
        
        struct Response
        {
            var title: String
            var message: String
            
            init() {
                self.title = "Error"
                self.message = "Something went wrong."
            }
            
            init(message: String) {
                self.title = "Error"
                self.message = message
            }
            
            init(title: String, message: String) {
                self.title = title
                self.message = message
            }
        }
        
        struct ViewModel {
            var title: String
            var message: String
            
            init() {
                self.title = "Error"
                self.message = "Something went wrong."
            }
            
            init(title: String, message: String) {
                self.title = title
                self.message = message
            }
        }
    }
}
