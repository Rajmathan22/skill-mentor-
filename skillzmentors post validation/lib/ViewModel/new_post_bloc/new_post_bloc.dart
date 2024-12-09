import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:skillzmentors/ViewModel/new_post_bloc/new_post_event.dart';
import 'package:skillzmentors/ViewModel/new_post_bloc/new_post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final ImagePicker _picker = ImagePicker();

  PostBloc()
      : super(PostLoaded(
          selectedImages: [],
          description: '',
          isPrivate: true,
        )) {
    on<PostInitialEvent>((event, emit) {
      emit(PostLoaded(
        selectedImages: [],
        description: '',
        isPrivate: true,
      ));
    });

    on<PickImagesEvent>((event, emit) async {
      try {
        final List<XFile>? pickedImages = await _picker.pickMultiImage();
        if (pickedImages != null) {
          final currentState = state as PostLoaded;
          emit(PostLoaded(
            selectedImages: [...currentState.selectedImages, ...pickedImages],
            description: currentState.description,
            isPrivate: currentState.isPrivate,
          ));
        }
      } catch (e) {
        emit(PostError("Failed to pick images: $e"));
      }
    });

    on<TogglePrivacyEvent>((event, emit) {
      if (state is PostLoaded) {
        final currentState = state as PostLoaded;
        emit(PostLoaded(
          selectedImages: currentState.selectedImages,
          description: currentState.description,
          isPrivate: !currentState.isPrivate,
        ));
      }
    });

    on<UpdateDescriptionEvent>((event, emit) {
      if (state is PostLoaded) {
        final currentState = state as PostLoaded;
        emit(PostLoaded(
          selectedImages: currentState.selectedImages,
          description: event.description,
          isPrivate: currentState.isPrivate,
        ));
      }
    });

    on<UploadDataEvent>((event, emit) async {
      if (state is PostLoaded) {
        final currentState = state as PostLoaded;
        emit(PostLoading());
        try {
          final uri =
              Uri.parse('https://skillzmentors.vercel.app/api/api/feeds');
          final request = http.MultipartRequest('POST', uri);

          // Add Bearer token to the headers
          const String bearerToken =
              "1|W13cpHhmWPTHCIrkmBK0l8t0kLl3ooA00R9vUdxj199229dc"; // Replace with your actual token
          request.headers['Authorization'] = 'Bearer $bearerToken';

          // Add visibility and description
          request.fields['visibility'] =
              currentState.isPrivate ? 'private' : 'public';
          request.fields['content'] = currentState.description;

          // Add selected images
          for (final image in currentState.selectedImages) {
            final imageData = await image.readAsBytes();
            request.files.add(
              http.MultipartFile.fromBytes(
                'media[]',
                imageData,
                filename: image.path.split('/').last,
                contentType: MediaType('image', 'jpeg'),
              ),
            );
          }

          final response = await request.send();
          if (response.statusCode == 201) {
            emit(PostUploadedSuccessfully());
          } else {
            emit(PostError('Failed to upload post: ${response.statusCode}'));
          }
        } catch (e) {
          emit(PostError('Error during upload: $e'));
        }
      }
    });
  }
}
