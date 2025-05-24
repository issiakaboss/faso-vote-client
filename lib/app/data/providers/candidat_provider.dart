import 'package:faso_vote_client/app/data/models/candidat.dart';
import 'package:faso_vote_client/app/data/providers/base_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/api/exception.dart';
import '../../utils/enums/api_routes.dart';
import '../../utils/helpers/image_helper.dart';
import 'api_provider.dart';

class CandidatProvider with BaseProvider {
  Future<List<Candidat>?> fetchCandidats(
      {required int voteId, ValueSetter<String>? onError}) async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL: ApiRoutes.voteCandidats.format({"vote": voteId.toString()}),
      );
      if (response != null) {
        final List<Candidat> candidatList =
            (response['data']["candidates"] as List)
                .map((item) => Candidat.fromJson(item))
                .toList();

        return candidatList;
      }
      return null;
    } on ApiException catch (e) {
      if (onError != null) onError(e.message ?? '');
      return [];
    } catch (e) {
      if (onError != null) onError('Erreur inattendue: ${e.toString()}');
      return [];
    }
  }

  Future<Candidat?> fetchEditCandidatData(
      {required int candidatId, ValueSetter<String>? onError}) async {
    try {
      final response = await ApiProvider.get(
        auth: true,
        apiURL:
            ApiRoutes.editCandidat.format({"candidat": candidatId.toString()}),
      );
      if (response != null) {
        final Candidat editCandidat = Candidat.fromJson(response['data']);

        return editCandidat;
      }
      return null;
    } on ApiException catch (e) {
      if (onError != null) onError(e.message ?? '');
      return null;
    } catch (e) {
      if (onError != null) onError('Erreur inattendue: ${e.toString()}');
      return null;
    }
  }

  Future<dynamic> storeCandidate({
    required Map<String, dynamic> candidat,
    PlatformFile? photo,
    ValueSetter<String>? onError,
  }) async {
    try {
      showLoading();

      final List<http.MultipartFile> files = [];

      if (photo != null) {
        final compressed = await ImageHelper.compressImage(photo);
        if (compressed != null) {
          final sizeInKB = compressed.length / 1024;
          const maxSizeInKB = 2048;
          if (sizeInKB > maxSizeInKB) {
            throw Exception(
              'La photo est trop volumineuse (${sizeInKB.toStringAsFixed(2)} KB). Max autorisé : $maxSizeInKB KB.',
            );
          }

          files.add(http.MultipartFile.fromBytes(
            'photo',
            compressed,
            filename: 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg',
          ));
        }
      }

      final response = await ApiProvider.multipartPost(
        auth: true,
        apiURL: ApiRoutes.candidats.path,
        fields: {
          'vote_id': candidat['vote_id'],
          'full_name': candidat['full_name'] ?? '',
          'university': candidat['university'] ?? '',
          'theme': candidat['theme'] ?? ''
        },
        files: files,
      );

      hideLoading();
      return response;
    } on ApiException catch (e) {
      hideLoading();
      onError?.call(e.message ?? 'Erreur lors de l’enregistrement du candidat');
      return null;
    } catch (e) {
      hideLoading();
      onError?.call('Erreur inattendue: ${e.toString()}');
      return null;
    }
  }
  Future<dynamic> editCandidate({
    required String candidatId,
    required Map<String, dynamic> candidat,
    PlatformFile? photo,
    ValueSetter<String>? onError,
  }) async {
    try {
      showLoading();
      final List<http.MultipartFile> files = [];
      if (photo != null) {
        final compressed = await ImageHelper.compressImage(photo);
        if (compressed != null) {
          final sizeInKB = compressed.length / 1024;
          const maxSizeInKB = 2048;
          if (sizeInKB > maxSizeInKB) {
            throw Exception(
              'La photo est trop volumineuse (${sizeInKB.toStringAsFixed(2)} KB). Max autorisé : $maxSizeInKB KB.',
            );
          }
          files.add(http.MultipartFile.fromBytes(
            'photo',
            compressed,
            filename: 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg',
          ));
        }
      }
      final response = await ApiProvider.multipartUpdate(
        auth: true,
        apiURL: ApiRoutes.candidats.format({'candidat':candidatId}),
        fields: {
          'vote_id': candidat['vote_id'],
          'full_name': candidat['full_name'] ?? '',
          'university': candidat['university'] ?? '',
          'theme': candidat['theme'] ?? ''
        },
        files: files,
      );
      hideLoading();
      return response;
    } on ApiException catch (e) {
      hideLoading();
      onError?.call(e.message ?? 'Erreur lors de modification du candidat');
      return null;
    } catch (e) {
      hideLoading();
      onError?.call('Erreur inattendue: ${e.toString()}');
      return null;
    }
  }

    Future<bool> deleteCandidat({
    required String candidatId,
    ValueSetter<String>? onError,
  }) async {
    try {
      showLoading();
      final response = await ApiProvider.delete(
        auth: true,
        apiURL: ApiRoutes.deleteCandidat.format({'candidat': candidatId}),
      ).catchError(handleError);
      hideLoading();
      return response != null;
    } on ApiException catch (e) {
      hideLoading();
      if (onError != null) onError(e.message ?? '');
      return false;
    } catch (e) {
      hideLoading();
      debugPrint('Erreur inattendue: ${e.toString()}');
      if (onError != null) onError('Erreur inattendue: ${e.toString()}');
      return false;
    }
  }
}
