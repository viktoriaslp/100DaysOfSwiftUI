//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Victoria Slyunko on 4/7/25.
//

import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    
    // Enum to define the type of filter to apply to the list
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    // Access to the SwiftData model context
    @Environment(\.modelContext) var modelContext
    // Query to fetch all prospects, sorted by name
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    
    @State private var isShowingScanner = false
    @State private var selectedProspects = Set<Prospect>()
    
    // Property to store the selected filter type
    var filter: FilterType
    
    // Navigation title changes based on the selected filter
    var title: String {
        switch filter {
        case .none:
            "All People"
        case .contacted:
            "Contacted People"
        case .uncontacted:
            "Uncontacted People"
        }
    }
    
    var body: some View {
        // List of prospects (filtered later in init if needed)
        List(prospects, selection: $selectedProspects) { prospect in
            
            // Tapping a row opens the EditingView for that specific prospect using a NavigationLink.
            NavigationLink {
                EditingView(prospect: prospect)
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.title)
                        
                        Text(prospect.emailAddress)
                            .foregroundStyle(.secondary)
                    }
                    // Show a checkmark icon only in the “Everyone” tab and only if the person has been contacted
                    if filter == .none && prospect.isContacted {
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                    }
                }
            }
            // Swipe actions: delete or toggle contact status
            .swipeActions {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    modelContext.delete(prospect)
                }
                
                // Toggle contact status depending on current state
                if prospect.isContacted {
                    Button("Marc Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.blue)
                } else {
                    Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.green)
                    
                    // If the prospect is not contacted add a notification reminder.
                    Button("Add notification", systemImage: "bell") {
                        addNotification(for: prospect)
                    }
                    .tint(.orange)
                }
            }
            // Allow selection of each row
            .tag(prospect)
        }
        .navigationTitle(title)
        // Toolbar with buttons
        .toolbar {
            // Button to show QR code scanner sheet
            ToolbarItem(placement: .topBarTrailing) {
                Button("Scan", systemImage: "qrcode.viewfinder") {
                    isShowingScanner = true
                }
            }
            // Enable edit mode to allow row selection
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
            // Show delete button if any items are selected
            if selectedProspects.isEmpty == false {
                ToolbarItem(placement: .bottomBar) {
                    Button("Delete selection", action: delete)
                }
            }
        }
        // QR code scanner sheet view
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
        }
        // Clears the selection when returning from the editing view to avoid showing it as still selected.
        .onAppear() {
            selectedProspects = []
        }
    }
    
    // Custom initializer to apply filtering logic if needed
    // Called automatically when creating ProspectsView with a filter
    // Allow ProspectsView to receive a custom filter and sort descriptor, and update the @Query accordingly.
    init(filter: FilterType, sort: SortDescriptor<Prospect>) {
        self.filter = filter
        
        // If a filter is set, override the default @Query to apply it
        if filter != .none {
            let showContactedOnly = filter == .contacted
            
            // Apply predicate to filter based on isContacted status
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [sort])
        } else {
            _prospects = Query(sort: [sort])
        }
    }
    
    // Handles result from the QR code scanner
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            // Expecting "name\nemail" format
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
            modelContext.insert(person)
            
        case .failure(let error):
            print("Scanning Failed: \(error.localizedDescription)")
        }
    }
    
    // Delete all selected prospects from the database
    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }
    
    // Function to add a local notification reminding to contact a specific person
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        // Define the request creation as a closure
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)."
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            // Create a trigger that fires after 5 seconds
            // (In a real app, you could use UNCalendarNotificationTrigger for a specific date/time)
                    
            //        var dateComponents = DateComponents()
            //        dateComponents.hour = 9
            //
            //        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        // Check if the user has already granted notification permissions
        center.getNotificationSettings { setting in
            if setting.authorizationStatus == .authorized {
                // If authorized, add the notification immediately
                addRequest()
            } else {
                // If not authorized, request permission.
                center.requestAuthorization(options: [.alert, .badge, .sound]) { succes, error in
                    if succes {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
            
        }
    }
}

#Preview {
    ProspectsView(filter: .none, sort: SortDescriptor(\Prospect.name))
        .modelContainer(for: Prospect.self)
}
