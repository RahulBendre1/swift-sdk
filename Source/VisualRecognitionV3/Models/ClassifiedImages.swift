/**
 * Copyright IBM Corporation 2016
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation
import Freddy

/** The results from classifying one or more images. */
public struct ClassifiedImages: JSONDecodable {
    
    /// The number of images processed.
    public let imagesProcessed: Int
    
    /// The images that were classified.
    public let images: [ClassifiedImage]
    
    /// Any warnings produced during classification.
    public let warnings: [WarningInfo]?
    
    /// Used internally to initialize a `ClassifiedImages` model from JSON.
    public init(json: JSON) throws {
        imagesProcessed = try json.getInt(at: "images_processed")
        images = try json.decodedArray(at: "images", type: ClassifiedImage.self)
        warnings = try? json.decodedArray(at: "warnings", type: WarningInfo.self)
    }
}

/** A classified image. */
public struct ClassifiedImage: JSONDecodable {
    
    /// The source URL of the image that was classified.
    public let sourceURL: String?
    
    /// The resolved URL of the image that was classified.
    public let resolvedURL: String?
    
    /// The filename of the image that was classified.
    public let image: String?
    
    /// Information about an error that occurred while classifying the given image.
    public let error: ErrorInfo?
    
    /// Classifications of the given image by classifier.
    public let classifiers: [ClassifierResults]
    
    /// Used internally to initialize a `ClassifiedImage` model from JSON.
    public init(json: JSON) throws {
        sourceURL = try? json.getString(at: "source_url")
        resolvedURL = try? json.getString(at: "resolved_url")
        image = try? json.getString(at: "image")
        error = try? json.decode(at: "error")
        classifiers = try json.decodedArray(at: "classifiers", type: ClassifierResults.self)
    }
}

/** A classifier's classifications for a given image. */
public struct ClassifierResults: JSONDecodable {
    
    /// The name of the classifier.
    public let name: String
    
    /// The id of the classifier. Only returned for custom classifiers.
    public let classifierID: String?
    
    /// The classes identified by the classifier.
    public let classes: [Classification]
    
    /// Used internally to initialize a `ClassifierResults` model from JSON.
    public init(json: JSON) throws {
        name = try json.getString(at: "name")
        classifierID = try json.getString(at: "classifier_id")
        classes = try json.decodedArray(at: "classes", type: Classification.self)
    }
}

/** The classification of an image. */
public struct Classification: JSONDecodable {
    
    /// The class identified by the classifier.
    public let classification: String
    
    /// The confidence score of the identified class.
    public let score: Double
    
    /// The type hierarchy of the identified class.
    public let typeHierarchy: String?
    
    /// Used internally to initialize a `Classification` model from JSON.
    public init(json: JSON) throws {
        classification = try json.getString(at: "class")
        score = try json.getDouble(at: "score")
        typeHierarchy = try? json.getString(at: "type_hierarchy")
    }
}
