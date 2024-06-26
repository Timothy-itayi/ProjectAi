import UIKit
import CoreLocation

class CafeViewController: UIViewController {
    // Cafe object to display details
    var cafe: CafeManager.Cafe
    
    // CafeManager to access cafe array
    var cafeManager: CafeManager?
    
    // UI elements
    let nameLabel = UILabel()
    let scrollView = UIScrollView()
    var imageViews = [UIImageView]()
    let addressLabel = UILabel()
    let hoursLabel = UILabel()
    let descriptionLabel = UILabel()
    let ratingLabel = UILabel()
    
    // MARK: - Initialization
    init(cafe: CafeManager.Cafe, cafeManager: CafeManager) {
        self.cafe = cafe
        self.cafeManager = cafeManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        displayCafeDetails()
    }
    
    // MARK: - UI Setup
    private func setupViews() {
        view.backgroundColor = .white
        
        // Add name label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 2
        nameLabel.font = UIFont.systemFont(ofSize: 34)
        view.addSubview(nameLabel)
        
        // Add scrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black
        view.addSubview(scrollView)
        
        // Add hours label
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        hoursLabel.numberOfLines = 0
        view.addSubview(hoursLabel)
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.numberOfLines = 0
        view.addSubview(ratingLabel)
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.numberOfLines = 0
        view.addSubview(addressLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)
        
        
        // Layout constraints
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addressLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            hoursLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            hoursLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hoursLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            scrollView.topAnchor.constraint(equalTo: hoursLabel.bottomAnchor, constant: 30),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 600),
            
            
            
        ])
    }
    
    
    // MARK: - Display Cafe Details
    
    private func displayCafeDetails() {
        
        // Name label //
        nameLabel.text = cafe.name
        nameLabel.numberOfLines = 0 // Allow multiple lines for the label
        nameLabel.lineBreakMode = .byWordWrapping // Wrap the text to new line when needed

        let nameLabelFont = UIFont(name: "Sling-Bold", size: 30)
        if let nameLabelFont = nameLabelFont {
            nameLabel.font = nameLabelFont
        }
        nameLabel.textAlignment = .left

        
        // Rating Label //
        let fullStar = "\u{2605}" // Unicode for full star
        let emptyStar = "\u{2606}" // Unicode for empty star

        let ratingStarString = String(repeating: fullStar, count: Int(cafe.rating)) + String(repeating: emptyStar, count: 5 - Int(cafe.rating))
        let ratingCustomColor = UIColor(red: 49.0/255.0, green: 95.0/255.0, blue: 114.0/255.0, alpha: 1.0)
        let ratingStarAttributedString = NSAttributedString(string: ratingStarString, attributes: [.foregroundColor: ratingCustomColor]) // Create an attributed string with the rating stars and the specified color
        ratingLabel.attributedText = ratingStarAttributedString // Set the attributed text to the label

        
        // Description Label //
        descriptionLabel.text = cafe.description
        let descriptionTextColor =  UIColor(red: 110.0/255.0, green: 107.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        let descriptionLabelFont = UIFont(name:"Inter-SemiBold", size: 14)
        descriptionLabel.textColor = descriptionTextColor
        if let descriptionLabelFont = descriptionLabelFont{
            descriptionLabel.font = descriptionLabelFont
            
        }
        descriptionLabel.textAlignment = .left
        
        
        // Address Label //
        
        addressLabel.text = cafe.address
        
        let addressLabelFont = UIFont(name: "Inter-Regular", size: 20)
        if let addressLabelFont = addressLabelFont {
            addressLabel.font = addressLabelFont
            
        }
        addressLabel.textAlignment = .left
        
        
        // Add images to scrollView
        var previousImageView: UIImageView?
        
        for image in cafe.images {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
            
            // Set constraints relative to the previous image view or scrollView if it's the first one
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                imageView.heightAnchor.constraint(equalToConstant: imageView.bounds.height), // Use image height
            ])
            
            if let previous = previousImageView {
                // If there's a previous image view, constrain the top of the current image view to the bottom of the previous one
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10),
                ])
            } else {
                // If there's no previous image view, this is the first one, so constrain its top to the top of the scrollView
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
                ])
            }
            
            // Set the bottom constraint of the scrollView to the bottom of the last image view
            if image == cafe.images.last {
                NSLayoutConstraint.activate([
                    scrollView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100),
                ])
            }
            
            previousImageView = imageView
        }
        
        // Activate the constraints
        view.layoutIfNeeded()
        
        
        // Get the current weekday
        let weekday = Calendar.current.component(.weekday, from: Date())
        
        // Determine status and time text
        let openStatusText: String
        let closedStatusText: String
        let openingTimeText: String
        let closingTimeText: String
        
        if cafe.isOpen() {
            openStatusText = "Open"
            closedStatusText = ""
            openingTimeText = ""
            closingTimeText = "Closes at \(closingTimeFormatted(cafe.openingHours[weekday - 1].1))"
            // Set label text color
            let openCustomColor = UIColor(red: 52.0/255.0, green: 92.0/255.0, blue: 20.0/255.0, alpha: 1.0)
            hoursLabel.textColor = openCustomColor
            hoursLabel.font = UIFont.boldSystemFont(ofSize: hoursLabel.font.pointSize)
        } else {
            closedStatusText = "Closed"
            openStatusText = ""
            openingTimeText = "Opens at \(openingTimeFormatted(cafe.openingHours[weekday - 1].0))"
            closingTimeText = ""
            // Set label text color
            let closedCustomColor = UIColor(red: 173.0/255.0, green: 0.0, blue: 10.0/255.0, alpha: 1.0)
            
            hoursLabel.textColor = closedCustomColor
        }
        
        // Construct label text based on cafe status
        var labelText: String
        let spacing = "  "
        if cafe.isOpen() {
            labelText = "\(openStatusText) \(openingTimeText) \(closedStatusText) \(closingTimeText) "
        } else {
            labelText = "\(closedStatusText)\(spacing) \(openingTimeText) \(openStatusText) \(closingTimeText) "
        }
        
        // Set label text
        hoursLabel.text = labelText
        
        // Set text colors for opening and closing time texts
        let openingTimeRange = (hoursLabel.text! as NSString).range(of: openingTimeText)
        let closingTimeRange = (hoursLabel.text! as NSString).range(of: closingTimeText)
        
        let attributedText = NSMutableAttributedString(string: hoursLabel.text!)
        let customColor = UIColor(red: 110.0/255.0, green: 107.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        
        attributedText.addAttribute(.foregroundColor, value: customColor, range: openingTimeRange)
        attributedText.addAttribute(.foregroundColor, value: customColor, range: closingTimeRange)
        
        hoursLabel.attributedText = attributedText
        
        
        // Helper method to format closing time
        func closingTimeFormatted(_ closingTime: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: closingTime)
        }
        
        // Helper method to format opening time
        func openingTimeFormatted(_ openingTime: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: openingTime)
        }
        
   
    }
    
}
