//
//  MomentEntryView.swift
//  GratefulMoments
//
//  Created by Brian Kabiru on 27/02/2026.
//

import SwiftUI
import PhotosUI

struct MomentEntryView: View {
    @State private var title = ""
    @State private var note = ""
    @State private var imageData: Data?
    @State private var newImage: PhotosPickerItem?
    @State private var isShowingCancelConfirmation = false
    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer
    var body: some View {
        NavigationStack {
            ScrollView {
                contentStack
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Grateful For")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") {
                        if title.isEmpty, note.isEmpty, imageData == nil {
                            dismiss()
                        } else {
                            isShowingCancelConfirmation = true
                        }
                    }
                    .confirmationDialog("Discard Moment", isPresented: $isShowingCancelConfirmation) {
                        Button("Discard Moment", role: .destructive) {
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", systemImage: "checkmark") {
                        let newMoment = Moment(
                            title: title,
                            note: note,
                            imageData: imageData,
                            timeStamp: .now
                            )
                        dataContainer.context.insert(newMoment)
                        do {
                            try dataContainer.context.save()
                            dismiss()
                        } catch {
                        // dont dismiss
                        }
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    private var photoPicker: some View {
        PhotosPicker(selection: $newImage) {
            Group {
                if let imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "photo.badge.plus.fill")
                        .font(.largeTitle)
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                        .background(Color(white: 0.4, opacity: 0.32))
                }
            }
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .onChange(of: newImage) {
            guard let newImage else {
                return
            }
            Task {
    imageData = try await newImage.loadTransferable(type: Data.self)}
        }
    }

    var contentStack: some View {
        VStack(alignment: .leading) {
            TextField(text: $title) {
                Text("Title (Required)")
            }
                    .font(.title.bold())
                    .padding(.top, 48)
                    Divider()
            TextField("Log Your Small Wins", text: $note, axis: .vertical)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .lineLimit(5...Int.max)
            photoPicker
        }
        .padding()
    }
}

#Preview {
    MomentEntryView()
        .sampleDataContainer()
}
